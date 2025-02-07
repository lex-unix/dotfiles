local function find_python_modules()
    local modules = {}
    local cwd = vim.fn.getcwd()
    local handle = vim.fn.glob(cwd .. '/*/__main__.py', false, true)
    for _, path in ipairs(handle) do
        local module = vim.fn.fnamemodify(path, ':h:t')
        table.insert(modules, module)
    end

    return modules
end

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
        'mfussenegger/nvim-dap-python',
        lazy = true,
        ft = 'python',
        config = function()
            require('dap-python').setup('python3')

            table.insert(require('dap').configurations.python, {
                type = 'python',
                request = 'launch',
                name = 'Debug Test',
                module = 'pytest',
                args = { '${file}' },
            })

            table.insert(require('dap').configurations.python, {
                type = 'python',
                request = 'launch',
                name = 'Launch module',
                module = function()
                    local co = coroutine.running()
                    return coroutine.create(function()
                        local modules = find_python_modules()
                        vim.ui.select(modules, {
                            prompt = 'Select Python module: ',
                            format_item = function(item) return item end,
                        }, function(choice)
                            if choice then coroutine.resume(co, choice) end
                        end)
                    end)
                end,
            })
        end,
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
                    elements = { 'scopes' },
                    size = 0.3,
                    position = 'right',
                },
                {
                    elements = { 'repl', 'breakpoints' },
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
