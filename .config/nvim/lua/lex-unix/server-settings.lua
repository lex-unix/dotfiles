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
	yamlls = {
		yaml = {
			schemas = {
				['https://json.schemastore.org/prettierrc.json'] = '.prettierrc',
				['https://json.schemastore.org/eslintrc.json'] = '.eslintrc',
				['https://json.schemastore.org/clang-format.json'] = '.clang-format',
			},
			schemaDownload = {
				enable = true,
			},
		},
	},
}
