return {
    {
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
            { '<leader>ss', '<cmd>Telescope luasnip<CR>' },
            { '<leader>tt', '<cmd>Telescope resume<CR>' },
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
                            ['<C-q>'] = actions.smart_send_to_qflist,
                        },
                        i = {
                            ['<C-q>'] = actions.smart_send_to_qflist,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                },
            })

            telescope.load_extension('fzf')
            telescope.load_extension('luasnip')
        end,
    },
    {
        'benfowler/telescope-luasnip.nvim',
        event = 'InsertEnter',
    },
}
