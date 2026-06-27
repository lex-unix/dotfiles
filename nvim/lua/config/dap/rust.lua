local M = {}

local function codelldb_path()
    local executable = vim.fn.exepath('codelldb')
    if executable ~= '' then return executable end

    return vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin', 'codelldb')
end

local function pick_program(dap)
    return coroutine.create(function(co)
        vim.ui.input({
            prompt = 'Path to executable: ',
            default = vim.fn.getcwd() .. '/target/debug/',
            completion = 'file',
        }, function(input)
            if input == nil or input == '' then
                coroutine.resume(co, dap.ABORT)
                return
            end

            coroutine.resume(co, input)
        end)
    end)
end

function M.setup(dap)
    local adapter = {
        type = 'executable',
        command = codelldb_path(),
    }

    dap.adapters.codelldb = adapter
    dap.adapters.lldb = adapter

    dap.configurations.rust = {
        {
            name = 'Launch Rust binary',
            type = 'codelldb',
            request = 'launch',
            program = function() return pick_program(dap) end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            sourceLanguages = { 'rust' },
        },
        {
            name = 'Attach to process',
            type = 'codelldb',
            request = 'attach',
            pid = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
            sourceLanguages = { 'rust' },
        },
    }
end

return M
