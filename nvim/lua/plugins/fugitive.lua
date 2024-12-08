return {
    'tpope/vim-fugitive',
    keys = {
        { '<leader>gs', vim.cmd.G, desc = 'Open fugitive' },
        {
            '<leader>gl',
            '<CMD>Git log --pretty=format:"%h (%cd) [%an] %s %d" --date=relative<CR>',
            desc = 'Open git log',
        },
    },
    cmd = 'Git',
    config = function()
        local GitFugitive = vim.api.nvim_create_augroup('GitFugitive', {})

        vim.api.nvim_create_autocmd('BufWinEnter', {
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
