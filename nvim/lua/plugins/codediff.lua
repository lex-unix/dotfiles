return {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
    opts = {
        keymaps = {
            view = {
                next_hunk = ']h',
                prev_hunk = '[h',
            },
        },
    },
}
