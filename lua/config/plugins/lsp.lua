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
                list = {
                    selection = {
                        preselect = function(ctx)
                            return ctx.mode ~= 'cmdline'
                                and not require('blink.cmp').snippet_active({ direction = 1 })
                        end,
                    }
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
            -- UI Configs
            local hover = vim.lsp.buf.hover
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.lsp.buf.hover = function()
                return hover({ border = "rounded" })
            end

            -- Setup Mason
            require("mason").setup()

            -- Get LSP capabilities
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Setup language servers.
            vim.lsp.config('*', {
                capabilities = capabilities,
                root_markers = { ".git" },
            })

            -- Lua LS
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
            vim.lsp.enable("lua_ls")

            -- Ruff
            vim.lsp.config.ruff = {
                cmd = { "ruff", "server" },
                filetypes = { "python" },
            }
            vim.lsp.enable("ruff")

            -- Pyright
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
            vim.lsp.enable("pyright")

            -- Terraform
            vim.lsp.config.tf_ls = {
                cmd = { "terraform-ls", "serve" },
                filetypes = { "terraform", "terraform-vars" },
            }
            vim.lsp.enable("tf_ls")

            -- JSON
            vim.lsp.config.jsonls = {
                cmd = { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                init_options = { provideFormatter = true },
            }
            vim.lsp.enable("jsonls")

            -- Format on save
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = "LSP Actions",
                group = vim.api.nvim_create_augroup('lsp-actions', {}),
                callback = function(args)
                    -- Get client
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- No client found
                    if not client then return end

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
