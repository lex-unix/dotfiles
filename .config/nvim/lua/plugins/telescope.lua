local function telescope_buffer_dir() return vim.fn.expand('%:p:h') end

local file_browser_opts = {
    path = '%:p:h',
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = 'normal',
    layout_config = { height = 40 },
}

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
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
            {
                'sf',
                function() require('telescope').extensions.file_browser.file_browser(file_browser_opts) end,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd('VimEnter', {
                callback = function()
                    if vim.fn.argv(0) == '' then
                        require('telescope').extensions.file_browser.file_browser(file_browser_opts)
                    end
                end,
            })
        end,
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            local fb_actions = require('telescope').extensions.file_browser.actions

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
                extensions = {
                    file_browser = {
                        theme = 'dropdown',
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            -- your custom insert mode mappings
                            ['i'] = {
                                ['<C-w>'] = function() vim.cmd('normal vbd') end,
                            },
                            ['n'] = {
                                -- your custom normal mode mappings
                                ['N'] = fb_actions.create,
                                ['h'] = fb_actions.goto_parent_dir,
                                ['.'] = fb_actions.toggle_hidden,
                                ['/'] = function() vim.cmd('startinsert') end,
                            },
                        },
                    },
                },
            })

            telescope.load_extension('file_browser')
            telescope.load_extension('fzf')
            telescope.load_extension('luasnip')
        end,
    },
}
