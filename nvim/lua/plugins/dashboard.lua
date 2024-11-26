return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
        { '<leader>od', '<Cmd>:lua Snacks.dashboard.open()<CR>', desc = 'Open dashboard' },
    },
    opts = {
        dashboard = {
            enabled = true,
            width = 60,
            row = nil, -- dashboard position. nil for center
            col = nil, -- dashboard position. nil for center
            pane_gap = 4, -- empty columns between vertical panes
            autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
            -- These settings are used by some built-in sections
            preset = {
                -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                ---@type fun(cmd:string, opts:table)|nil
                pick = nil,
                -- Used by the `keys` section to show keymaps.
                -- Set your custom keymaps here.
                -- When using a function, the `items` argument are the default keymaps.
                keys = {
                    {
                        icon = ' ',
                        key = 'f',
                        desc = 'Find File',
                        action = ":lua Snacks.dashboard.pick('files')",
                    },
                    { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
                    {
                        icon = ' ',
                        key = 'g',
                        desc = 'Find Text',
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },
                    {
                        icon = ' ',
                        key = 'r',
                        desc = 'Recent Files',
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = ' ',
                        key = 'c',
                        desc = 'Config',
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                    {
                        icon = '󰒲 ',
                        key = 'L',
                        desc = 'Lazy',
                        action = ':Lazy',
                        enabled = package.loaded.lazy ~= nil,
                    },
                    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                },
                -- Used by the `header` section
                header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
            },
            -- item field formatters
            formats = {
                icon = function(item)
                    if item.file and item.icon == 'file' or item.icon == 'directory' then
                        return M.icon(item.file, item.icon)
                    end
                    return { item.icon, width = 2, hl = 'icon' }
                end,
                footer = { '%s', align = 'center' },
                header = { '%s', align = 'center' },
                file = function(item, ctx)
                    local fname = vim.fn.fnamemodify(item.file, ':~')
                    fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
                    local dir, file = fname:match('^(.*)/(.+)$')
                    return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } } or { { fname, hl = 'file' } }
                end,
            },
            sections = {
                { section = 'header' },
                { section = 'keys', gap = 1, padding = 1 },
                { section = 'startup' },
            },
        },
    },
}
