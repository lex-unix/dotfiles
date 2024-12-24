local configs = require('config.lsp.config')

return {
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = function() require('mason').setup({}) end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        event = 'BufReadPre',
        config = function()
            local lspconfig = require('mason-lspconfig')
            local nvim_lsp = require('lspconfig')

            lspconfig.setup({
                automatic_installation = true,
            })

            lspconfig.setup_handlers({
                function(server_name)
                    local config = configs[server_name] or configs['BASE']
                    nvim_lsp[server_name].setup(vim.tbl_extend('force', configs['BASE'], config))
                end,
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        config = function()
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'rounded',
            })

            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = '●' },
                severity_sort = true,
                float = { source = 'if_many' },
            })

            -- Diagnostic symbols in the sign column (gutter)
            local signs = { Error = '󰅚 ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        event = 'BufReadPre',
        config = function()
            local null_ls = require('null-ls')
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

            local lsp_formatting = function(bufnr)
                vim.lsp.buf.format({
                    filter = function(client) return client.name == 'null-ls' end,
                    bufnr = bufnr,
                })
            end

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettierd.with({
                        extra_filetypes = { 'prisma', 'astro', 'svelte' },
                    }),
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.fish,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.terraform_fmt,
                    null_ls.builtins.formatting.nixfmt,
                    null_ls.builtins.formatting.google_java_format,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = augroup,
                            buffer = bufnr,
                            callback = function() lsp_formatting(bufnr) end,
                        })
                    end
                end,
            })

            vim.api.nvim_create_user_command(
                'DisableLspFormatting',
                function() vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 }) end,
                { nargs = 0 }
            )
        end,
    },
    {
        'glepnir/lspsaga.nvim',
        cmd = 'Lspsaga',
        keys = {
            { '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>' },
            { 'K', '<Cmd>Lspsaga hover_doc<CR>' },
            { 'gd', '<Cmd>Lspsaga goto_definition<CR>' },
            { 'gp', '<Cmd>Lspsaga peek_definition<CR>' },
            { 'gr', '<Cmd>Lspsaga rename<CR>' },
            { 'gf', '<Cmd>Lspsaga finder<CR>' },
            { '<leader>ca', '<cmd>Lspsaga code_action<CR>', mode = { 'n', 'v' } },
        },
        opts = {
            diagnostic = {
                auto_preview = false,
            },
            ui = {
                title = true,
                winblend = 0,
                border = 'rounded',
            },
            symbol_in_winbar = {
                enable = false,
            },
            lightbulb = {
                enable = false,
            },
        },
    },
    {
        'dmmulroy/ts-error-translator.nvim',
        event = 'BufReadPre',
        opts = {},
    },
}
