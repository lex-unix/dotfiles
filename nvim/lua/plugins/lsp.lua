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
        event = { 'BufReadPre', 'BufNewFile' },
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
        event = { 'BufReadPre', 'BufNewFile' },
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
                    source = true,
                },
            })
        end,
    },
    {
        'glepnir/lspsaga.nvim',
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
}
