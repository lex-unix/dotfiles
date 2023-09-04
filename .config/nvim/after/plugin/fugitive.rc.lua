vim.keymap.set('n', '<leader>gs', vim.cmd.G)
vim.keymap.set(
	'n',
	'<leader>gl',
	'<CMD>Git log --pretty=format:"%C(red)%h %C(reset)(%cd) %C(reset)%s %C(yellow)%d %C(reset)" --date=relative<CR>'
)
