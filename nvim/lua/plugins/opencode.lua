return {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    keys = {
        { '<leader>oA', function() require('opencode').ask(nil, { submit = true }) end, desc = 'Ask opencode' },
        {
            '<leader>oa',
            function() require('opencode').ask('@cursor: ', { submit = true }) end,
            desc = 'Ask opencode about this',
        },
        {
            '<leader>oa',
            function() require('opencode').ask('@selection: ', { submit = true }) end,
            mode = 'v',
            desc = 'Ask opencode about selection',
        },
        { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New opencode session' },
        {
            '<leader>oy',
            function() require('opencode').command('messages_copy') end,
            desc = 'Copy last opencode response',
        },
        {
            '<leader>os',
            function() require('opencode').select() end,
            mode = { 'n', 'v' },
            desc = 'Select opencode prompt',
        },
    },
    init = function()
        vim.opt.autoread = true
        vim.api.nvim_create_autocmd('User', {
            pattern = 'OpencodeEvent',
            callback = function(args)
                if args.data.type == 'session.idle' then
                    vim.notify('opencode finished responding', vim.log.levels.INFO)
                end
            end,
        })
    end,
}
