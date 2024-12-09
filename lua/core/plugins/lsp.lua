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

            -- Trigger
            trigger = {
                completion = {
                    blocked_trigger_characters = { ' ', '\n', '\t', ',', '{', '}', },
                    show_on_insert_on_trigger_character = false,
                },
            },

            -- Windows
            windows = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    border = "rounded",
                },
            },

            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',

            -- experimental auto-brackets support
            -- accept = { auto_brackets = { enabled = true } }

            -- experimental signature help support
            -- trigger = { signature_help = { enabled = true } }
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        "snacks.nvim",
                        "lazy.nvim",
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- UI Configs
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = 'rounded' }
            )
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = 'rounded' }
            )
            vim.diagnostic.config({
                float = {
                    border = 'rounded',
                    source = true,
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '✘',
                        [vim.diagnostic.severity.WARN] = '▲',
                        [vim.diagnostic.severity.HINT] = '⚑',
                        [vim.diagnostic.severity.INFO] = '»',
                    },
                },
                underline = true,
            })

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                end,
            })

            -- For Pyright / Ruff
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then
                        return
                    end
                    if client.name == 'ruff' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = 'LSP: Disable hover capability from Ruff',
            })

            -- Format on save
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Format on save",
                group = vim.api.nvim_create_augroup("lsp", { clear = true }),
                callback = function(args)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format { async = false, id = args.data.client_id }
                        end,
                    })
                end
            })

            -- LSP Config
            local lspconfig = require('lspconfig')

            require("mason").setup()
            require('mason-lspconfig').setup({
                automatic_installation = false,
                ensure_installed = {
                    "cssls",
                    "eslint",
                    "gopls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "ruff",
                    "ts_ls",
                    "unocss",
                    "vimls",
                    "volar"
                },
                handlers = {
                    -- Common for all servers
                    function(server_name)
                        lspconfig[server_name].setup({})
                    end,
                    -- typescript
                    ["ts_ls"] = function()
                        local vue_typescript_plugin = require('mason-registry')
                            .get_package('vue-language-server')
                            :get_install_path()
                            .. '/node_modules/@vue/language-server'
                            .. '/node_modules/@vue/typescript-plugin'

                        lspconfig.ts_ls.setup({
                            init_options = {
                                plugins = {
                                    {
                                        name = "@vue/typescript-plugin",
                                        location = vue_typescript_plugin,
                                        languages = { 'javascript', 'typescript', 'vue' }
                                    },
                                }
                            },
                            filetypes = {
                                'javascript',
                                'javascriptreact',
                                'javascript.jsx',
                                'typescript',
                                'typescriptreact',
                                'typescript.tsx',
                                'vue',
                            },
                        })
                    end,
                },
            })
        end,
    }
}
