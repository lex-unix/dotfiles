return {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
        require('nvim-surround').setup({
            move_cursor = 'sticky',
        })
    end,
}
