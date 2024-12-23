return {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    event = 'InsertEnter',
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        local ls = require('luasnip')
        ls.setup({})
    end,
}
