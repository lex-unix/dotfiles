return {
    'folke/zen-mode.nvim',
    lazy = true,
    keys = {
        { '<leader>z', '<cmd>ZenMode<CR>', silent = true, desc = 'Zen Mode' },
    },
    config = function()
        require('zen-mode').setup({
            plugins = {
                tmux = true,
            },
        })
        vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<cr>', { silent = true })
    end,
}
