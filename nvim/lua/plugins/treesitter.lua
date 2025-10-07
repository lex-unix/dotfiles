return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate',
        event = 'BufReadPre',
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    disable = {},
                },
                indent = {
                    enable = true,
                    disable = { 'python' },
                },
                sync_install = false,
                auto_install = true,
                ensure_installed = {
                    'tsx',
                    'toml',
                    'fish',
                    'json',
                    'yaml',
                    'css',
                    'html',
                    'lua',
                    'python',
                    'rust',
                    'go',
                    'markdown',
                    'markdown_inline',
                },
                autotag = {
                    enable = false,
                },
            })

            local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

            vim.treesitter.language.register('markdown', 'mdx')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'BufReadPre',
        config = function()
            require('nvim-treesitter.configs').setup({
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>sn'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>sp'] = '@parameter.inner',
                        },
                    },
                    select = {
                        enable = true,
                        -- include_surrounding_whitespace = true,
                        lookahead = true,
                        selection_modes = {
                            ['@function.outer'] = 'V',
                            ['@function.inner'] = 'V',
                            ['@class.outer'] = 'V',
                            ['@class.inner'] = 'V',
                        },
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['ia'] = '@parameter.inner',
                            ['aa'] = '@parameter.outer',
                            ['i/'] = '@comment.inner',
                            ['a/'] = '@comment.outer',
                            ['it'] = '@html_tag.inner',
                            ['at'] = '@html_tag.outer',
                        },
                    },
                },
            })
        end,
    },
}
