return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'rcarriga/nvim-dap-ui',
        'leoluz/nvim-dap-go',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        -- UI settings
        dapui.setup({
            controls = {
                element = 'repl',
                enabled = true,
                icons = {
                    disconnect = '',
                    pause = '',
                    play = '',
                    run_last = '',
                    step_back = '',
                    step_into = '',
                    step_out = '',
                    step_over = '',
                    terminate = '',
                },
            },
            force_buffers = true,
            element_mappings = {},
            icons = { expanded = '▾', collapsed = '▸', current_frame = '' },
            mappings = {
                open = 'o',
                remove = 'd',
                edit = 'e',
                repl = 'r',
                toggle = 't',
            },
            expand_lines = vim.fn.has('nvim-0.7') == 1,
            layouts = {
                {
                    elements = {
                        'scopes',
                    },
                    size = 0.3,
                    position = 'right',
                },
                {
                    elements = {
                        'repl',
                        'breakpoints',
                    },
                    size = 0.3,
                    position = 'bottom',
                },
            },
            floating = {
                max_height = nil,
                max_width = nil,
                border = 'single',
                mappings = {
                    close = { 'q', '<Esc>' },
                },
            },
            windows = { indent = 1 },
            render = {
                indent = 1,
                max_type_length = nil,
            },
        })

        -- start debugging session
        vim.keymap.set('n', '<leader>ds', function()
            dap.continue()
            dapui.toggle({})
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
        end)

        -- set breakpoints, get variable values, step into/out of functions, etc.
        vim.keymap.set('n', '<leader>dv', require('dap.ui.widgets').hover)
        vim.keymap.set('n', '<leader>dc', dap.continue)
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>dn', dap.step_over)
        vim.keymap.set('n', '<leader>di', dap.step_into)
        vim.keymap.set('n', '<leader>do', dap.step_out)
        vim.keymap.set('n', '<leader>dC', dap.clear_breakpoints)

        -- close debugger and clear breakpoints
        vim.keymap.set('n', '<leader>de', function()
            dap.clear_breakpoints()
            dapui.toggle({})
            dap.terminate()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
        end)

        -- configured lanugage specific extensions
        require('dap-go').setup()
    end,
}
