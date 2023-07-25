local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = require('lex-unix.shared').on_attach
local capabilities = require('lex-unix.shared').capabilities

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

protocol.CompletionItemKind = {
  '', -- Text
  '󰊕', -- Method
  '󰊕', -- Function
  '󰊕', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  '󰜰', -- Interface
  '󰏗', -- Module
  '', -- Property
  '', -- Unit
  '󰎠', -- Value
  '', -- Enum
  '󰌋', -- Keyword
  '󰚬', -- Snippet
  '', -- Color
  '', -- File
  '󰆑', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  '󰘧', -- Operator
  '', -- TypeParameter
}


nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

-- Set up rust-analyzer
nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      assists = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      proMacro = {
        enable = true
      },
    }
  }
}

-- Set up Pyright for completion only
nvim_lsp.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    ['textDocument/publishDiagnostics'] = function(...)
    end
  },
  settings = {
    typeCheckingMode = 'off',
    python = {
      analysis = {
        typeCheckingMode = 'off',
      },
    },
    pyright = {
      disableDiagnostics = true,
    }
  }
}

-- Set up diagnostic-languageserver for flake8
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'python' },
  init_options = {
    linters = {
      flake8 = {
        sourceName = 'flake8',
        command = 'flake8',
        args = { [[--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s]], '-' },
        debounce = 100,
        offsetLine = 0,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          [[(\d+),(\d+),([A-Z]),(.*)(\r|\n)*$]],
          { line = 1, column = 2, security = 3, message = { '[flake8] ', 4 } },
        },
        securities = {
          W = 'warning',
          E = 'error',
          F = 'error',
          C = 'error',
          N = 'error',
        },
      },
    },
    filetypes = {
      python = 'flake8',
    },
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  }
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
