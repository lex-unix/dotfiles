return {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        local ls = require('luasnip')

        ls.setup({
            history = true,
            update_events = 'TextChanged,TextChangedI',
            enable_autosnippets = true,
        })

        vim.keymap.set({ 'i', 's' }, '<c-k>', function()
            if ls.expand_or_jumpable() then ls.expand_or_jump() end
        end, { silent = true })

        vim.keymap.set({ 'i', 's' }, '<c-j>', function()
            if ls.jumpable() then ls.jump(-1) end
        end, { silent = true })
        vim.keymap.set({ 'i', 's' }, '<c-l>', function()
            if ls.choice_active() then ls.change_choice(1) end
        end, { silent = true })
    end,
}
