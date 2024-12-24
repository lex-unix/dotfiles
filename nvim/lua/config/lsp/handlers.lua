return {
    pyright = {
        ['textDocument/publishDiagnostics'] = function(...) end,
    },
    ts_ls = {
        ['textDocument/publishDiagnostics'] = function(err, result, ctx)
            local ok, ts_error_translator = pcall(require, 'ts-error-translator')
            if ok then ts_error_translator.translate_diagnostics(err, result, ctx) end
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
        end,
    },
}
