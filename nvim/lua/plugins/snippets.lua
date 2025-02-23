return {
    'chrisgrieser/nvim-scissors',
    dependencies = 'nvim-telescope/telescope.nvim',
    cmd = { 'ScissorsEditSnippet', 'ScissorsAddNewSnippet' },
    opts = {
        snippetDir = vim.fn.stdpath('config') .. '/snippets',
    },
}
