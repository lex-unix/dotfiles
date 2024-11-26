local blacklist = { '.DS_Store', '.git', 'node_modules', '.venv', '.docker' }

return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'VimEnter */*,.*', 'BufNew */*,.*' },
    keys = {
        { 'sf', '<cmd>Oil<CR>', desc = 'Open parent directory' },
    },
    opts = {
        columns = { 'icon' },
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                if vim.list_contains(blacklist, name) then return true end
                return false
            end,
        },
        skip_confirm_for_simple_edits = true,
        keymaps = {
            ['q'] = 'actions.close',
        },
    },
}
