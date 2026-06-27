local function pad_dashboard_header(lines)
    local width = 0

    for _, line in ipairs(lines) do
        width = math.max(width, vim.fn.strdisplaywidth(line))
    end

    for i, line in ipairs(lines) do
        lines[i] = line .. string.rep(' ', width - vim.fn.strdisplaywidth(line))
    end

    return table.concat(lines, '\n')
end

return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
        { '<leader>sf', function() Snacks.picker.files({ exclude = { '.agents/**' } }) end, desc = 'Find Files' },
        { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
        { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
        { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
        { '<leader>sc', function() Snacks.picker.search_history() end, desc = 'Search command history' },
        { '<leader>tt', function() Snacks.picker.resume() end, desc = 'Resume' },
        { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
        { 'gr', function() Snacks.picker.lsp_references() end, desc = 'Goto References' },
        { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
        { '<leader>D', function() Snacks.picker.lsp_type_definitions() end, desc = 'Type Definition' },
        { '<leader>to', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    },
    opts = {
        terminal = {
            enabled = true,
            win = {
                wo = {
                    winbar = '',
                },
            },
        },
        input = { enabled = true },
        notifier = { enabled = true },
        picker = {
            sources = {
                files = {
                    hidden = true,
                    ignored = false,
                },
                grep = {
                    hidden = true,
                    ignored = false,
                },
            },
        },
        quickfile = {
            enabled = true,
        },
        statuscolumn = {
            enabled = true,
            left = { 'sign' },
            folds = {
                open = true,
                git_hl = true,
            },
        },
        dashboard = {
            enabled = true,
            width = 60,
            row = nil, -- dashboard position. nil for center
            col = nil, -- dashboard position. nil for center
            pane_gap = 4, -- empty columns between vertical panes
            autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
            preset = {
                pick = nil,
                keys = {
                    {
                        icon = ' ',
                        key = 'f',
                        desc = 'Find File',
                        action = ":lua Snacks.picker.files({exclude = {'.agents/**' }})",
                    },
                    {
                        icon = ' ',
                        key = 'g',
                        desc = 'Find Text',
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },
                    { icon = ' ', key = 'F', desc = 'File Browser', action = ':Oil' },
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
                header = pad_dashboard_header({
                    '                                             ',
                    '      ████ ██████           █████      ██',
                    '     ███████████             █████ ',
                    '     █████████ ███████████████████ ███   ███████████',
                    '    █████████  ███    █████████████ █████ ██████████████',
                    '   █████████ ██████████ █████████ █████ █████ ████ █████',
                    ' ███████████ ███    ███ █████████ █████ █████ ████ █████',
                    '██████  █████████████████████ ████ █████ █████ ████ ██████',
                }),
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
