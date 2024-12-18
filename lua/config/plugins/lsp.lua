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
                trigger = {
                    blocked_trigger_characters = { ' ', '\n', '\t', ',', '{', '}', },
                    show_on_insert_on_trigger_character = false,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "rounded" },
                },
            },

            -- Signature help
            signature = {
                enabled = true,
                window = { border = "rounded" },
            },

            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',

        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
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
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = 'rounded' }
            )

            -- Get LSP capabilities
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Handlers to be set with mason-lspconfig
            local handlers = {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup { capabilities = capabilities }
                end,
            }

            -- Setup mason and mason-lspconfig
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "gopls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "ruff",
                    "ts_ls",
                    "vimls",
                },
                automatic_installation = false,
                handlers = handlers,
            }

            -- LSP Customization
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = "LSP Actions",
                callback = function(args)
                    -- Get client
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- No client found
                    if not client then return end

                    -- Disable hover in favor of Pyright
                    if client.name == 'ruff' then
                        client.server_capabilities.hoverProvider = false
                    end

                    -- Keymaps
                    local opts = { buffer = args.buf }
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

                    -- Format on save
                    if client.supports_method('textDocument/formatting') then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
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
