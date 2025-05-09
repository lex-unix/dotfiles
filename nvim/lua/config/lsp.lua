return {
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
        handlers = {
            ['textDocument/publishDiagnostics'] = function(err, result, ctx)
                local ok, ts_error_translator = pcall(require, 'ts-error-translator')
                if ok then ts_error_translator.translate_diagnostics(err, result, ctx) end
                vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
            end,
        },
    },
}
