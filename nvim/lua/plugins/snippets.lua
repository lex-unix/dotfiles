return {
    {
        'chrisgrieser/nvim-scissors',
        cmd = { 'ScissorsEditSnippet', 'ScissorsAddNewSnippet' },
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
            editSnippetPopup = {
                keymaps = {
                    deleteSnippet = '<leader>d',
                },
            },
        },
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        event = 'InsertEnter',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            local ls = require('luasnip')
            ls.setup({})
        end,
    },
}
