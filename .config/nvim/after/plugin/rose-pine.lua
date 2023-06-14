local status, rosepine = pcall(require, 'rose-pine')
if (not status) then return end

rosepine.setup({
  disable_background = true,
  disable_float_background = true,
  disable_italics = true,
})


-- vim.cmd('colorscheme rose-pine')
