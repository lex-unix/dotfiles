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
                end,
            })

            -- vim.lsp.inlay_hint.enable(true)

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
        'dmmulroy/ts-error-translator.nvim',
        event = 'BufReadPre',
        opts = {
            auto_attach = true,
            servers = {
                'astro',
                'svelte',
                'ts_ls',
                'tsserver',
                'typescript-tools',
                'volar',
                'vtsls',
            },
        },
    },
    {
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'folke/trouble.nvim',
        opts = {},
        cmd = 'Trouble',
        keys = {
            {
                '<leader>sd',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>sD',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>sr',
                '<cmd>Trouble lsp toggle focus=false win.position=right win.size=45<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
        },
    },
}
