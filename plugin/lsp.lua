vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/folke/lazydev.nvim',
    'https://github.com/williamboman/mason.nvim',
})

-- blink.cmp setup
require('blink.cmp').setup {
    -- 'default' for mappings similar to built-in completion
    keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', "fallback" },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },

    -- Completion
    completion = {
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


-- mason setup
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

-- Vue LSP
-- ◍ vue-language-server
-- ◍ typescript-language-server
-- ◍ unocss-language-server
-- ◍ eslint-lsp

local vue_language_server_path =
    vim.fn.stdpath("data") .. "/mason/packages" .. "/vue-language-server/node_modules/@vue/language-server"


vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
            },
        },
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.config("vue_ls", {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json", ".git" },

    on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
            local ts_clients = vim.lsp.get_clients({
                bufnr = context.bufnr,
                name = "ts_ls",
            })

            if #ts_clients == 0 then
                vim.notify(
                    "Could not find vtsls client required by vue_ls",
                    vim.log.levels.ERROR
                )
                return
            end

            local ts_client = ts_clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)

            ts_client:exec_cmd(
                {
                    title = "vue_request_forward",
                    command = "typescript.tsserverRequest",
                    arguments = { command, payload },
                },
                { bufnr = context.bufnr },
                function(_, r)
                    local response_data = {
                        { id, r and r.body }
                    }
                    client:notify("tsserver/response", response_data)
                end
            )
        end
    end,
})

vim.lsp.config("unocss", {
    cmd = { "unocss-language-server", "--stdio" },
    filetypes = {
        "html",
        "vue",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_markers = { "uno.config.ts", "uno.config.js", "uno.config.mjs", "package.json", ".git" },
})

vim.lsp.config.eslint = {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
    root_markers = {
        'eslint.config.js',
        'eslint.config.mjs', 'eslint.config.ts',
        '.eslintrc.js',
        'package.json',
    },
    settings = {
        validate = 'on',
        useESLintClass = false,
        experimental = { useFlatConfig = true },
        codeActionOnSave = { enable = false, mode = 'all' },
        format = true,
        quiet = false,
        onIgnoredFiles = 'off',
        rulesCustomizations = {},
        run = 'onType',
        problems = { shortenToSingleLine = false },
        nodePath = '',
        workingDirectory = { mode = 'location' },
    },
}

vim.lsp.enable({ "ts_ls", "vue_ls", "unocss", "eslint" })

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

-- Fish LSP Config fish-lsp
vim.lsp.config.fish_ls = {
    cmd = { 'fish-lsp', 'start' },
    filetypes = { 'fish' },
}
vim.lsp.enable('fish_ls')

-- Vala LS Config [vala-language-server]
vim.lsp.config.vala_ls = {
    cmd = { 'vala-language-server' },
    filetypes = { 'vala', 'genie' },
    root_dir = vim.fs.dirname(
        vim.fs.find({ 'meson.build', '.git' }, { upward = true })[1]
    ),
}
vim.lsp.enable('vala_ls')

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
        kmset('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)

        -- Format on save
        if client:supports_method('textDocument/formatting') and client.name ~= 'vue_ls' then
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
