local on_attach = require('config.shared').on_attach
local capabilities = require('config.shared').capabilities
local settings = require('config.lsp.settings')
local handlers = require('config.lsp.handlers')

return {
    BASE = {
        on_attach = on_attach,
        capabilities = capabilities,
    },
    lua_ls = {
        settings = settings['lua_ls'],
    },
    yamlls = {
        settings = settings['yamlls'],
    },
    jsonls = {
        settings = settings['jsonls'],
    },
    pyright = {
        settings = settings['pyright'],
        handlers = handlers['pyright'],
    },
    tailwindcss = {
        init_options = {
            userLanguages = {
                elixir = 'html-eex',
                eelixir = 'html-eex',
                heex = 'html-eex',
            },
        },
    },
    ts_ls = {
        handlers = handlers['ts_ls'],
    },
}
