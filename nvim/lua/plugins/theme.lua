return {
    'mellow-theme/mellow.nvim',
    enabled = true,
    priority = 1000,
    config = function() vim.cmd('colorscheme mellow') end,
}
