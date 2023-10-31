local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
}

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "buffer" },
  })
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")
lspconfig["lua_ls"].setup {
  capabilities = capabilities
}
lspconfig["bashls"].setup {
  capabilities = capabilities
}
lspconfig["dockerls"].setup {
  capabilities = capabilities
}
lspconfig["jsonls"].setup {
  capabilities = capabilities
}
lspconfig["marksman"].setup {
  capabilities = capabilities
}
lspconfig["pyright"].setup {
  capabilities = capabilities
}
lspconfig["taplo"].setup {
  capabilities = capabilities
}
lspconfig["yamlls"].setup {
  capabilities = capabilities
}
