return {
    {
        'Shatur/neovim-ayu',
        enabled = false,
        priority = 1000,
        config = function()
            local colors = require('ayu.colors')
            colors.generate()

            require('ayu').setup({
                overrides = {
                    LineNr = { fg = colors.comment },
                    BlinkCmpSignatureHelpActiveParameter = { bg = colors.selection_bg },
                },
            })

            vim.cmd('colorscheme ayu')
        end,
    },
    {
        'sainnhe/gruvbox-material',
        enabled = true,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_colors_override = { bg0 = { '#171819', '234' } }
            vim.g.gruvbox_material_visual = 'blue background'
            vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
            vim.g.gruvbox_material_diagnostic_line_highlight = 1
            vim.g.gruvbox_material_enable_bold = 1
            vim.g.gruvbox_material_float_style = 'dim'

            vim.cmd('colorscheme gruvbox-material')

            -- reset highlights for lsp-saga diagnostics and floats
            vim.api.nvim_set_hl(0, 'DiagnosticError', { link = 'Red' })
            vim.api.nvim_set_hl(0, 'DiagnosticHint', { link = 'Green' })
            vim.api.nvim_set_hl(0, 'DiagnosticWarn', { link = 'Yellow' })
            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none', fg = '#d4be98' })
            vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = '#d4be98' })
        end,
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        enabled = false,
        opts = {},
        config = function() vim.cmd([[colorscheme tokyonight-night]]) end,
    },
}
