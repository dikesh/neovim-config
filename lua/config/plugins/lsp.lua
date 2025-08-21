return {
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = "*",

        opts = {
            -- 'default' for mappings similar to built-in completion
            keymap = {
                preset = 'default',
                ['<CR>'] = { 'accept', "fallback" },
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
            },

            -- Completion
            completion = {
                accept = { auto_brackets = { enabled = false } },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "rounded" },
                },
                trigger = {
                    show_on_insert_on_trigger_character = false,
                },
            },

            -- Signature help
            signature = {
                enabled = true,
                window = { border = "rounded" },
                trigger = {
                    blocked_trigger_characters = { ' ', '\n', '\t', ',', '{', '}', },
                    show_on_insert_on_trigger_character = false,
                },
            },

            -- Command Line
            cmdline = {
                keymap = {
                    preset = 'cmdline',
                    ['<CR>'] = { 'select_accept_and_enter', 'fallback' },
                },
            },
        }
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        "snacks.nvim",
                        "lazy.nvim",
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            "saghen/blink.cmp",
        },
        config = function()
            -- Setup Mason
            require("mason").setup()

            -- Get LSP capabilities
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Setup language servers.
            vim.lsp.config('*', {
                capabilities = capabilities,
                root_markers = { ".git" },
            })

            -- Lua LS Config [lua-language-server]
            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            }
            vim.lsp.enable('lua_ls')

            -- Ruff Server Config [ruff]
            vim.lsp.config.ruff = {
                cmd = { "ruff", "server" },
                filetypes = { "python" },
            }
            vim.lsp.enable('ruff')

            -- Pyright LS Config [pyright]
            vim.lsp.config.pyright = {
                cmd = { "pyright-langserver", "--stdio" },
                filetypes = { "python" },
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            useLibraryCodeForTypes = true
                        }
                    }
                }
            }
            vim.lsp.enable('pyright')

            -- Terraform LS Config [terraform-ls]
            vim.lsp.config.tf_ls = {
                cmd = { "terraform-ls", "serve" },
                filetypes = { "terraform", "terraform-vars" },
            }
            vim.lsp.enable('tf_ls')

            -- JSON LS Config [json-lsp]
            vim.lsp.config.json_ls = {
                cmd = { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                init_options = { provideFormatter = true },
            }
            vim.lsp.enable('json_ls')

            -- TS LS Config [typescript-language-server]
            vim.lsp.config.ts_ls = {
                init_options = { hostInfo = 'neovim' },
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = {
                    'javascript',
                    'javascriptreact',
                    'javascript.jsx',
                    'typescript',
                    'typescriptreact',
                    'typescript.tsx',
                },
                root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
            }
            vim.lsp.enable('ts_ls')

            -- HTML LS Config [html-lsp]
            vim.lsp.config.html_ls = {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html" },
                init_options = {
                    provideFormatter = true,
                    embeddedLanguages = { css = true, javascript = true },
                    configurationSection = { 'html', 'css', 'javascript' },
                },
            }
            vim.lsp.enable('html_ls')

            -- Rust Analyzer config [rust-analyzer]
            vim.lsp.config.rust_analyzer = {
                cmd = { 'rust-analyzer' },
                filetypes = { 'rust' },
            }
            vim.lsp.enable('rust_analyzer')

            -- Nushell
            vim.lsp.config.nushell = {
                cmd = { 'nu', '--lsp' },
                filetypes = { 'nu' },
            }
            vim.lsp.enable('nushell')

            -- Format on save
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = "LSP Actions",
                group = vim.api.nvim_create_augroup('lsp-actions', {}),
                callback = function(args)
                    -- Get client
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- No client found
                    if not client then return end

                    -- Keymaps
                    local opts = { buffer = args.buf }
                    local kmset = vim.keymap.set
                    kmset('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                    kmset('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
                    kmset('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)

                    -- Format on save
                    if client:supports_method('textDocument/formatting') then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            group = vim.api.nvim_create_augroup('lsp-actions', { clear = false }),
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })
        end
    }
}
