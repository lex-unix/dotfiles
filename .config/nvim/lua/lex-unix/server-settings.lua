return {
	lua_ls = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
		},
	},
	rust_analyzer = {
		['rust-analyzer'] = {
			assists = {
				importGranularity = 'module',
				importPrefix = 'self',
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			proMacro = {
				enable = true,
			},
		},
	},
}
