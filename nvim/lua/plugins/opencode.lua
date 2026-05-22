return {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    keys = {
        { '<leader>oA', function() require('opencode').ask(nil, { submit = true }) end, desc = 'Ask opencode' },
        {
            '<leader>oa',
            function() require('opencode').ask('@this: ', { submit = true }) end,
            mode = { 'n', 'v' },
            desc = 'Ask opencode about this',
        },
        { '<leader>on', function() require('opencode').command('session.new') end, desc = 'New opencode session' },
        {
            '<leader>os',
            function() require('opencode').select() end,
            mode = { 'n', 'v' },
            desc = 'Select opencode action (prompt or command)',
        },
    },
    init = function()
        local opencode_cmd = 'opencode --port --continue'
        local snacks_terminal_opts = {
            win = {
                position = 'right',
                enter = false,
                on_win = function(win) require('opencode.terminal').setup(win.win) end,
                wo = {
                    winbar = '',
                },
            },
        }
        vim.g.opencode_opts = {
            server = {
                start = function() require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts) end,
                stop = function()
                    local t = require('snacks.terminal').get(opencode_cmd, { create = false })
                    if t then t:close() end
                end,
                toggle = function() require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts) end,
            },
        }
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
