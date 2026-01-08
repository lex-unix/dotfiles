---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
    local conform = require('conform')
    for i = 1, select('#', ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then return formatter end
    end
    return select(1, ...)
end

return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>f',
            function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
            mode = '',
        },
    },
    init = function()
        vim.api.nvim_create_user_command('FormatDisable', function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = 'Disable autoformat-on-save',
            bang = true,
        })
        vim.api.nvim_create_user_command('FormatEnable', function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = 'Re-enable autoformat-on-save',
        })
    end,
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
            local disable_filetypes = { c = true, cpp = true }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt,
            }
        end,
        formatters_by_ft = {
            lua = { 'stylua' },
            nix = { 'nixfmt' },
            sql = { 'sql_formatter' },
            mysql = { 'sql_formatter' },
            java = { 'google-java-format' },
            terraform = { 'terraform_fmt' },
            markdown = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            javascript = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            typescript = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            typescriptreact = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            html = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            svelte = { 'prettierd' },
            astro = { 'prettierd' },
            json = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            jsonc = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            yaml = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
            toml = function(bufnr) return { first(bufnr, 'oxfmt', 'prettierd') } end,
        },
    },
}
