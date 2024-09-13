local blacklist = { '.DS_Store', '.git', 'node_modules', '.venv', '.docker' }

return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('oil').setup({
            columns = { 'icon' },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    if vim.list_contains(blacklist, name) then return true end
                    return false
                end,
            },
            keymaps = {
                ['q'] = 'actions.close',
            },
        })

        vim.keymap.set('n', 'sf', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
}
