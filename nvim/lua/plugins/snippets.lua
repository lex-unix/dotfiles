return {
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
}
