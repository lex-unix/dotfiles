return {
    gopls = {
        settings = {
            gopls = {
                buildFlags = { '-tags=unit,integration' },
            },
        },
    },
    lua_ls = {
        settings = {
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
    },
    pyright = {
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
        handlers = {
            ['textDocument/publishDiagnostics'] = function(...) end,
        },
    },
    tailwindcss = {
        settings = {
            tailwindCSS = {
                classFunctions = { 'cva', 'cx' },
            },
        },
        init_options = {
            userLanguages = {
                elixir = 'html-eex',
                eelixir = 'html-eex',
                heex = 'html-eex',
            },
        },
    },
    ts_ls = {
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'none',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = false,
                    includeInlayVariableTypeHints = false,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                    includeInlayPropertyDeclarationTypeHints = false,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'none',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayVariableTypeHints = false,
                    includeInlayFunctionParameterTypeHints = false,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                    includeInlayPropertyDeclarationTypeHints = false,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
    },
}
