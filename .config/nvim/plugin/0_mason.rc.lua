local status, mason = pcall(require, 'mason')
if not status then return end
local status2, lspconfig = pcall(require, 'mason-lspconfig')
if not status2 then return end
local status3, nvim_lsp = pcall(require, 'lspconfig')
if not status3 then return end

local on_attach = require('lex-unix.shared').on_attach
local capabilities = require('lex-unix.shared').capabilities
local settings = require('lex-unix.server-settings')

mason.setup({})

lspconfig.setup({
	automatic_installation = true,
})

lspconfig.setup_handlers({
	function(server_name)
		nvim_lsp[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = settings[server_name],
			handlers = (settings[server_name] or {}).handlers,
		})
	end,
	clangd = function()
		nvim_lsp.clangd.setup({
			on_attach = on_attach,
			capabilities = {
				capabilities,
				offsetEncoding = 'utf-8',
			},
		})
	end,
})
