return {
    'Shatur/neovim-ayu',
    enabled = true,
    priority = 1000,
    config = function()
        local colors = require('ayu.colors')
        colors.generate()

        require('ayu').setup({
            overrides = {
                LineNr = { fg = colors.comment },
            },
        })

        vim.cmd('colorscheme ayu')
    end,
}
