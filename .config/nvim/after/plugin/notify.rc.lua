local status, notify = pcall(require, 'notify')
if (not status) then return end

notify.setup({
  background_colour = "#000000",
  max_width = 65,
  stages = "fade_in_slide_out",
  timeout = 2000,
  fps = 180
})

vim.notify = notify
