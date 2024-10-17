return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
        config = function()
            require('lsp-zero').ui({
                float_border = 'rounded',
            })
        end
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })

            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                if client.name == 'ruff' then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            -- Format lua on save
            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['cssls'] = { "css" },
                    ['jsonls'] = { "json" },
                    ['lua_ls'] = { "lua" },
                    ['ruff'] = { 'python' },
                    ['ts_ls'] = { 'typescript', 'javascript' },
                    ['eslint'] = { 'vue', 'html' },
                }
            })

            lsp_zero.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    "cssls",
                    "eslint",
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
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                    -- Setup for volar
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    unocss = function()
                        require('lspconfig').unocss.setup({})
                    end,
                    volar = function()
                        require('lspconfig').volar.setup({})
                    end,
                    ts_ls = function()
                        local vue_typescript_plugin = require('mason-registry')
                            .get_package('vue-language-server')
                            :get_install_path()
                            .. '/node_modules/@vue/language-server'
                            .. '/node_modules/@vue/typescript-plugin'

                        require('lspconfig').ts_ls.setup({
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
                }
            })
        end
    }
}
