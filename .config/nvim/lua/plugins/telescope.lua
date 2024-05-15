return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        {
            '<leader>sf',
            function() require('telescope.builtin').find_files({ no_ignore = false, hidden = true }) end,
        },
        {
            '<leader>sg',
            function() require('telescope.builtin').live_grep() end,
        },
        {
            '<leader>sh',
            function() require('telescope.builtin').help_tags() end,
        },
        {
            '<leader>sd',
            function() require('telescope.builtin').diagnostics() end,
        },
        {
            '<leader>ss',
            '<cmd>Telescope luasnip<CR>',
            desc = 'Telescope luasnip',
        },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                sorting_strategy = 'ascending',
                file_ignore_patterns = { '%.git$', '%.jpeg', '%.jpg', '%.webp', '%.pdf', '%.png' },
                mappings = {
                    n = {
                        ['q'] = actions.close,
                    },
                },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('luasnip')
    end,
}
