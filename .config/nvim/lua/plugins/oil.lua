return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('oil').setup({
            columns = { 'icon' },
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ['q'] = 'actions.close',
            },

            vim.keymap.set('n', 'sf', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
        })
    end,
}
