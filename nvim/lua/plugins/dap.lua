return {
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'rcarriga/nvim-dap-ui' },
        keys = {
            { '<leader>dc', function() require('dap').continue() end },
            { '<leader>db', function() require('dap').toggle_breakpoint() end },
            { '<leader>dn', function() require('dap').step_over() end },
            { '<leader>di', function() require('dap').step_into() end },
            { '<leader>do', function() require('dap').step_out() end },
            { '<leader>dC', function() require('dap').clear_breakpoints() end },
            { '<leader>dt', function() require('dap').terminate() end },
            { '<leader>dj', function() require('dap').down() end },
            { '<leader>dk', function() require('dap').up() end },
        },
        config = function()
            local dap = require('dap')
            require('config.dap.js').setup(dap)

            local icons = {
                Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
                Breakpoint = ' ',
                BreakpointCondition = ' ',
                BreakpointRejected = { ' ', 'DiagnosticError' },
                LogPoint = '.>',
            }

            vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

            for name, sign in pairs(icons) do
                sign = type(sign) == 'table' and sign or { sign }
                vim.fn.sign_define(
                    'Dap' .. name,
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
                )
            end

            local vscode = require('dap.ext.vscode')
            local json = require('plenary.json')
            vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end
        end,
    },
    {
        'leoluz/nvim-dap-go',
        lazy = true,
        ft = 'go',
        opts = {},
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        lazy = true,
        keys = {
            { '<leader>du', function() require('dapui').toggle({}) end },
            { '<leader>dv', function() require('dapui').eval() end, mode = { 'n', 'v' } },
        },
        opts = {
            mappings = {
                open = 'o',
                remove = 'd',
                edit = 'e',
                repl = 'r',
                toggle = 't',
            },
            layouts = {
                {
                    elements = { 'watches', 'scopes' },
                    size = 0.3,
                    position = 'right',
                },
                {
                    elements = { 'stacks', 'breakpoints' },
                    size = 0.3,
                    position = 'bottom',
                },
            },
            windows = { indent = 1 },
        },
        config = function(_, opts)
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup(opts)
            dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
            dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
            dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
        end,
    },
}
