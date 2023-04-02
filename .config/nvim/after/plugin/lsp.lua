local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
}

lsp.setup()
