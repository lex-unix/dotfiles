local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

local on_attach = require('lex-unix.shared').on_attach
local capabilities = require('lex-unix.shared').capabilities

mason.setup({})

lspconfig.setup {
  automatic_installation = true,
}

lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities

    }
  end,
  ['clangd'] = function()
    require('lspconfig').clangd.setup {

      on_attach = on_attach,
      capabilities = {
        capabilities,
        offsetEncoding = "utf-8",
      }
    }
  end,

})
