return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.G)
        vim.keymap.set(
            'n',
            '<leader>gl',
            '<CMD>Git log --pretty=format:"%C(red)%h %C(reset)(%cd) %C(reset)%s %C(yellow)%d %C(reset)" --date=relative<CR>'
        )

        local GitFugitive = vim.api.nvim_create_augroup('GitFugitive', {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd('BufWinEnter', {
            group = GitFugitive,
            pattern = '*',
            callback = function()
                if vim.bo.ft ~= 'fugitive' then return end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set('n', '<leader>p', function() vim.cmd.Git('push') end, opts)
                vim.keymap.set('n', '<leader>P', function() vim.cmd.Git({ 'pull', '--rebase' }) end, opts)
                vim.keymap.set('n', '<leader>t', ':Git push -u origin ', opts)
            end,
        })
    end,
}
