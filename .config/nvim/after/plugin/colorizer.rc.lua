local status, colorizer = pcall(require, "colorizer")
if (not status) then return end

colorizer.setup({
  '*';
  html = { names = false; };
  css = { names = false; };
  javascript = { names = false; };
  typescript = { names = false; };
})
colorizer.attach_to_buffer()
colorizer.detach_from_buffer(nil)
