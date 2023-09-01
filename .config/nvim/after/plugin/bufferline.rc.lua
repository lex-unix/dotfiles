local status, bufferline = pcall(require, 'bufferline')
if not status then return end

bufferline.setup({
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
			bg = '#1E2021',
			fg = '#839496',
		},
		fill = {
			bg = '#1E2021',
		},
	},
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
