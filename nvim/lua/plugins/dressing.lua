return {
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
        keys = {
            { '<leader>st', '<CMD>TodoTelescope<CR>', desc = 'Search Todos' },
        },
        opts = {
            highlight = {
                after = '',
            },
        },
    },
}
