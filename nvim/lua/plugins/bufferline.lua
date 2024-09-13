return {
    'akinsho/nvim-bufferline.lua',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    keys = {
        { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'BufferLineCycleNext' },
        { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'BufferLineCyclePrev' },
    },
    config = function()
        require('bufferline').setup({
            options = {
                mode = 'tabs',
                separator_style = { '', '' },
                always_show_bufferline = true,
                enforce_regular_tabs = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                color_icons = false,
                indicator = {
                    style = 'none',
                },
            },
            highlights = {
                buffer_selected = {
                    bold = false,
                    italic = false,
                },
                background = {
                    bg = '#171819',
                    fg = '#839496',
                },
                fill = {
                    bg = '#171819',
                },
            },
        })
    end,
}
