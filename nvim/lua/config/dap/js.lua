local M = {}

function M.setup(dap)
    -- path to js-debug-adapter installed with Mason
    -- local package = require('mason-registry').get_package('js-debug-adapter')
    -- local debug_adapter_path = package:get_install_path() .. '/js-debug/src/dapDebugServer.js'
    local debug_adapter_path = vim.fn.exepath('js-debug-adapter') .. '/js-debug/src/dapDebugServer.js'

    local adapter = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
            command = 'node',
            args = { debug_adapter_path, '${port}' },
        },
    }

    if not dap.adapters['pwa-chrome'] then dap.adapters['pwa-chrome'] = adapter end
    if not dap.adapters['pwa-node'] then dap.adapters['pwa-node'] = adapter end

    if not dap.adapters['node'] then
        dap.adapters['node'] = function(cb, config)
            if config.type == 'node' then config.type = 'pwa-node' end
            local nativeAdapter = dap.adapters['pwa-node']
            if type(nativeAdapter) == 'function' then
                nativeAdapter(cb, config)
            else
                cb(nativeAdapter)
            end
        end
    end

    local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'svelte' }

    local vscode = require('dap.ext.vscode')
    vscode.type_to_filetypes['node'] = js_filetypes
    vscode.type_to_filetypes['pwa-node'] = js_filetypes
    vscode.type_to_filetypes['pwa-chrome'] = js_filetypes

    for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
            dap.configurations[language] = {
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                },
                {
                    type = 'pwa-node',
                    request = 'attach',
                    name = 'Attach',
                    processId = require('dap.utils').pick_process,
                    cwd = '${workspaceFolder}',
                },
                {
                    type = 'pwa-chrome',
                    request = 'launch',
                    name = 'Launch & Debug (Chrome)',
                    url = function()
                        local co = coroutine.running()
                        return coroutine.create(function()
                            vim.ui.input({
                                prompt = 'Enter URL: ',
                                default = 'http://localhost:3000',
                            }, function(url)
                                if url == nil or url == '' then
                                    return
                                else
                                    coroutine.resume(co, url)
                                end
                            end)
                        end)
                    end,
                    webRoot = vim.fn.getcwd(),
                    protocol = 'inspector',
                    sourceMaps = true,
                    userDataDir = false,
                },
            }
        end
    end
end

return M
