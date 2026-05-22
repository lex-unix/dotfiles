return {
    {
        'numToStr/Comment.nvim',
        event = 'BufReadPre',
        opts = {
            toggler = {
                line = '<leader>/',
            },
            opleader = {
                line = '<leader>/',
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>st', function() Snacks.picker.todo_comments() end, desc = 'Todo' },
        },
        opts = {
            highlight = { after = '' },
        },
    },
}
