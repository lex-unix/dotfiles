local status, kanagawa = pcall(require, 'kanagawa')
if (not status) then return end

kanagawa.setup({
  transparent = true,
  theme = "dragon",
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = 'none' },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = 'none' },
      TelescopePreviewBorder = { fg = theme.ui.bg_dim, bg = 'none' },

      MasonNormal = { fg = theme.ui.fg_dim },
    }
  end
})

vim.cmd("colorscheme kanagawa")