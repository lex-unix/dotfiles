return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
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
