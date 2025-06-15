local lsp_configs = require('config.lsp')

return {
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            { 'mason-org/mason.nvim', opts = {}, cmd = 'Mason' },
            'neovim/nvim-lspconfig',
        },
        event = 'BufReadPre',
        opts = {},
    },
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, 'Hover')
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
                    map('<leader>e', vim.diagnostic.open_float, 'Diagnostic error message')
                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                end,
            })

            vim.lsp.inlay_hint.enable(true)

            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
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

            for server_name, config in pairs(lsp_configs) do
                vim.lsp.config[server_name] = config
            end
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
        enabled = false,
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
    {
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {},
    },
}
