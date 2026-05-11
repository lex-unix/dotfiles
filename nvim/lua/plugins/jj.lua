return {
    {
        'julienvincent/hunk.nvim',
        dependencies = {
            'kevinhwang91/promise-async',
            'MunifTanjim/nui.nvim',
            'nvim-mini/mini.icons',
        },
        cmd = { 'DiffEditor' },
        opts = {},
    },
    {
        'NicolasGB/jj.nvim',
        keys = {
            { '<leader>jj', '<cmd>J<CR>', desc = 'jj log' },
            { '<leader>js', '<cmd>J status<CR>', desc = 'jj log' },
        },
        cmd = 'J',
        opts = {
            diff = {
                backend = 'diffview',
            },
        },
    },
}
