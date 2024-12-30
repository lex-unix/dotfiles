local M = {}

local augroup = vim.api.nvim_create_augroup('Format', { clear = true })
function M.on_attach(client, bufnr)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
        })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = false,
}
-- Set up completion using blink.cmp with LSP source
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
M.capabilities = capabilities

return M
