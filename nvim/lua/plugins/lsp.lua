local configs = require('config.lsp')

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

            lspconfig.setup({ automatic_installation = true })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = true,
                lineFoldingOnly = false,
            }
            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

            lspconfig.setup_handlers({
                function(server_name)
                    local config = configs[server_name] or {}
                    nvim_lsp[server_name].setup(vim.tbl_extend('force', { capabilities = capabilities }, config))
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
                severity_sort = true,
                float = { border = 'round', source = 'if_many' },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '󰅚 ',
                        [vim.diagnostic.severity.WARN] = '󰀪 ',
                        [vim.diagnostic.severity.INFO] = '󰋽 ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                    },
                },
                virtual_text = {
                    source = 'if_many',
                    prefix = '●',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            })
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        enabled = false,
        event = 'BufReadPre',
        config = function()
            local null_ls = require('null-ls')

            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.fish,
                },
            })
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
