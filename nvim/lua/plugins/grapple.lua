return {
    'cbochs/grapple.nvim',
    opts = {
        scope = 'git',
    },
    keys = {
        { '<leader>a', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
        { '<C-e>', '<cmd>Grapple toggle_tags<cr>', desc = 'Toggle tags menu' },

        { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
        { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
        { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
        { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },

        { '<leader>n', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
        { '<leader>p', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
    },
}
