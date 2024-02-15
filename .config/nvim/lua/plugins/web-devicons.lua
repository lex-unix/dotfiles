return {
    'nvim-tree/nvim-web-devicons',
    config = function()
        local icons = require('nvim-web-devicons')
        icons.setup({
            -- your personnal icons can go here (to override)
            -- DevIcon will be appended to `name`
            override = {},
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true,
        })

        icons.set_icon({
            astro = {
                icon = '',
                name = 'astro',
            },
        })
    end,
}
