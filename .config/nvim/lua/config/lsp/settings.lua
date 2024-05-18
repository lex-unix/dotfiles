return {
    lua_ls = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            format = {
                enable = false,
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
    jsonls = {
        json = {
            schemas = {
                {
                    description = 'NPM configuration file',
                    fileMatch = { 'package.json' },
                    name = 'package.json',
                    url = 'https://json.schemastore.org/package.json',
                },
                {
                    description = 'TypeScript compiler configuration file',
                    fileMatch = { 'tsconfig*.json', 'base.json' },
                    name = 'tsconfig.json',
                    url = 'https://json.schemastore.org/tsconfig.json',
                },
                {
                    description = 'TurboRepo, a tool for managing monorepos',
                    fileMatch = { 'turbo.json' },
                    name = 'Turborepo',
                    url = 'https://turbo.build/schema.json',
                },
            },
            validate = {
                enable = true,
            },
        },
    },
    pyright = {
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
}
