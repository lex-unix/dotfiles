return {
    {
        'rcarriga/nvim-dap-ui',
        lazy = true,
        opts = {
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
        },
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'nvim-neotest/nvim-nio', 'leoluz/nvim-dap-go' },
        keys = {
            {
                '<leader>ds',
                function()
                    require('dap').continue()
                    require('dapui').open()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
                end,
                desc = 'Start debugging session',
            },
            {
                '<leader>dv',
                function() require('dapui').eval() end,
            },
            {
                '<leader>dc',
                function() require('dap').continue() end,
            },
            {
                '<leader>db',
                function() require('dap').toggle_breakpoint() end,
            },
            {
                '<leader>dn',
                function() require('dap').step_over() end,
            },
            {
                '<leader>di',
                function() require('dap').step_into() end,
            },
            {
                '<leader>do',
                function() require('dap').step_out() end,
            },
            {
                '<leader>dC',
                function() require('dap').clear_breakpoints() end,
            },
            {
                '<leader>de',
                function()
                    local dap = require('dap')
                    dap.clear_breakpoints()
                    require('dapui').toggle({})
                    dap.terminate()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
                end,
            },
        },
    },
    {
        'leoluz/nvim-dap-go',
        lazy = true,
        opts = {},
    },
}
