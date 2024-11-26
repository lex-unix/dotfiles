return {
    'folke/zen-mode.nvim',
    lazy = true,
    keys = {
        { '<leader>z', '<cmd>ZenMode<CR>', silent = true, desc = 'Zen Mode' },
    },
    opts = {
        plugins = {
            tmux = true,
        },
    },
}
