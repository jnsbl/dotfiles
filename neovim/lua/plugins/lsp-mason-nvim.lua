local mason = require("mason")
mason.setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
  ensure_installed = {
    "lua_ls",
    "bashls",
    "dockerls",
    "jsonls",
    "marksman",
    "pyright",
    "taplo",
    "yamlls",
    "biome",
    "ts_ls",
  }
}

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "awesome", "client", "screen", "mouse",
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig.biome.setup {}
lspconfig.ts_ls.setup {}
