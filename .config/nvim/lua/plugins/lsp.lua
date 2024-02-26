local on_attach = require('config.shared').on_attach
local capabilities = require('config.shared').capabilities
local settings = require('config.server-settings')
local handlers = require('config.server-handlers')

return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        priority = 10,
        config = function()
            local mason = require('mason')
            local lspconfig = require('mason-lspconfig')
            local nvim_lsp = require('lspconfig')

            mason.setup({})

            lspconfig.setup({
                automatic_installation = true,
            })

            lspconfig.setup_handlers({
                function(server_name)
                    nvim_lsp[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = settings[server_name],
                        handlers = handlers[server_name] or {},
                    })
                end,
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            local protocol = require('vim.lsp.protocol')

            protocol.CompletionItemKind = {
                '', -- Text
                '󰊕', -- Method
                '󰊕', -- Function
                '󰊕', -- Constructor
                '', -- Field
                '', -- Variable
                '', -- Class
                '󰜰', -- Interface
                '󰏗', -- Module
                '', -- Property
                '', -- Unit
                '󰎠', -- Value
                '', -- Enum
                '󰌋', -- Keyword
                '󰚬', -- Snippet
                '', -- Color
                '', -- File
                '󰆑', -- Reference
                '', -- Folder
                '', -- EnumMember
                '', -- Constant
                '', -- Struct
                '', -- Event
                '󰘧', -- Operator
                '', -- TypeParameter
            }

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'rounded',
            })

            vim.lsp.handlers['textDocument/publishDiagnostics'] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    underline = true,
                    update_in_insert = false,
                    virtual_text = { spacing = 4, prefix = '●' },
                    severity_sort = true,
                })

            -- Diagnostic symbols in the sign column (gutter)
            local signs = { Error = '󰅚 ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end

            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                },
                update_in_insert = true,
                float = {
                    source = 'always', -- Or "if_many"
                },
            })
        end,
    },
    {
        'glepnir/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({
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
            })
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
            vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
            vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>', opts)
            vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
            vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
            vim.keymap.set('n', 'gf', '<Cmd>Lspsaga finder<CR>', opts)

            -- code action
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>')
        end,
    },
}
