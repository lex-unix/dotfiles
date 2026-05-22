return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    local treesitter = require('nvim-treesitter')
                    local available_langs = treesitter.get_available()
                    local is_available = vim.tbl_contains(available_langs, lang)

                    if is_available then
                        local installed_langs = treesitter.get_installed('parsers')
                        local installed = vim.tbl_contains(installed_langs, lang)

                        if not installed then treesitter.install(lang):wait() end

                        vim.treesitter.start()
                        if ev.match ~= 'python' then
                            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    end
                end,
            })
        end,
        config = function()
            require('nvim-treesitter').setup({
                install_dir = vim.fn.stdpath('data') .. '/site',
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        event = 'BufReadPre',
        config = function()
            local move = require('nvim-treesitter-textobjects.move')
            local select = require('nvim-treesitter-textobjects.select')
            local swap = require('nvim-treesitter-textobjects.swap')

            require('nvim-treesitter-textobjects').setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ['@function.outer'] = 'V',
                        ['@function.inner'] = 'V',
                        ['@class.outer'] = 'V',
                        ['@class.inner'] = 'V',
                    },
                },
                move = {
                    set_jumps = true,
                },
            })

            vim.keymap.set(
                { 'n', 'x', 'o' },
                ']m',
                function() move.goto_next_start('@function.outer', 'textobjects') end
            )
            vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
            vim.keymap.set(
                { 'n', 'x', 'o' },
                '[m',
                function() move.goto_previous_start('@function.outer', 'textobjects') end
            )
            vim.keymap.set(
                { 'n', 'x', 'o' },
                '[[',
                function() move.goto_previous_start('@class.outer', 'textobjects') end
            )

            vim.keymap.set('n', '<leader>sn', function() swap.swap_next('@parameter.inner') end)
            vim.keymap.set('n', '<leader>sp', function() swap.swap_previous('@parameter.inner') end)

            local textobjects = {
                af = '@function.outer',
                ['if'] = '@function.inner',
                ac = '@class.outer',
                ic = '@class.inner',
                ia = '@parameter.inner',
                aa = '@parameter.outer',
                ['i/'] = '@comment.inner',
                ['a/'] = '@comment.outer',
                it = '@html_tag.inner',
                at = '@html_tag.outer',
            }

            for lhs, query in pairs(textobjects) do
                vim.keymap.set({ 'x', 'o' }, lhs, function() select.select_textobject(query, 'textobjects') end)
            end
        end,
    },
}
