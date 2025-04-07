return {
    {
        'nvim-treesitter/nvim-treesitter',
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
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
                            -- You can also use captures from other query groups like `locals.scm`
                            ['as'] = { query = '@local.scope', query_group = 'locals', desc = 'Select language scope' },
                        },
                    },
                },
            })
        end,
    },
    {
        'apple/pkl-neovim',
        lazy = true,
        ft = 'pkl',
        build = function()
            require('pkl-neovim.internal').init()
            vim.cmd('TSInstall! pkl')
        end,
        config = function() require('luasnip.loaders.from_snipmate').lazy_load() end,
    },
}
