local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then return end

local protocol = require('vim.lsp.protocol')

local on_attach = require('lex-unix.shared').on_attach
local capabilities = require('lex-unix.shared').capabilities

protocol.CompletionItemKind = {
	'', -- Text
	'󰊕', -- Method
	'󰊕', -- Function
	'󰊕', -- Constructor
	'', -- Field
	'', -- Variable
	'', -- Class
	'󰜰', -- Interface
	'󰏗', -- Module
	'', -- Property
	'', -- Unit
	'󰎠', -- Value
	'', -- Enum
	'󰌋', -- Keyword
	'󰚬', -- Snippet
	'', -- Color
	'', -- File
	'󰆑', -- Reference
	'', -- Folder
	'', -- EnumMember
	'', -- Constant
	'', -- Struct
	'', -- Event
	'󰘧', -- Operator
	'', -- TypeParameter
}

-- Set up Pyright for completion only
nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	handlers = {
		['textDocument/publishDiagnostics'] = function(...) end,
	},
	settings = {
		typeCheckingMode = 'off',
		python = {
			analysis = {
				typeCheckingMode = 'off',
			},
		},
		pyright = {
			disableDiagnostics = true,
		},
	},
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = '●' },
	severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = '󰅚 ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = '●',
	},
	update_in_insert = true,
	float = {
		source = 'always', -- Or "if_many"
	},
})
