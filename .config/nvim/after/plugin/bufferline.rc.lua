local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
    options = {
        mode = "tabs",
        separator_style = 'slant',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true
    },
    highlights = {
        separator = {
            fg = '#1f1d2e',
            bg = '#21202e'
        },
        separator_selected = {
            fg = '#1f1d2e'
        },
        background = {
            fg = '#6e6a86',
            bg = '#21202e'
        },
        buffer_selected = {
            fg = '#e0def4',
            bold = true,
        },
        fill = {
            bg = '#1f1d2e'
        }
    },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
