local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })

  local opts = { buffer = bufnr }
  vim.keymap.set({ 'n', 'x' }, '<leader>lf', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end, opts)
end)


require('mason-lspconfig').setup({
  ensure_installed = { "pyright", "gopls", "lua_ls", "ruff" },
  handlers = {
    lsp_zero.default_setup,

    lua_ls = function()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            }
          }
        }
      })
    end,

    gopls = function()
      require('lspconfig').gopls.setup({})
    end,

    pyright = function()
      require('lspconfig').pyright.setup({})
    end,

    clangd = function()
      require("lspconfig").clangd.setup {
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      }
    end
  },
})


-- Set up custom LSP servers
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

if not configs.dbt_ls then
  vim.notify('dbt_ls not found, adding', vim.log.levels.WARN)
  configs.dbt_ls = {
    default_config = {
      cmd = { "python", "/Users/veltindupont/Documents/Perso/projects/dbt-lsp/src/lsp.py" },
      root_dir = lspconfig.util.root_pattern('dbt_project.yml'),
      filetypes = { 'sql', 'yaml'},
    },
  }
end
require('lspconfig').dbt_ls.setup({})

