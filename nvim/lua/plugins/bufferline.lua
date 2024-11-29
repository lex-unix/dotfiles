return {
    'akinsho/nvim-bufferline.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    keys = {
        { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'BufferLineCycleNext' },
        { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'BufferLineCyclePrev' },
        { 'te', ':tabedit', desc = 'New tab' },
    },
    opts = {
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
    },
}
