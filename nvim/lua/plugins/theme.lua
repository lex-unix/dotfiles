return {
    'mellow-theme/mellow.nvim',
    enabled = false,
    priority = 1000,
    config = function() vim.cmd('colorscheme mellow') end,
}
