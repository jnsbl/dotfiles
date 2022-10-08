local mason = require("mason")
mason.setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
  ensure_installed = {
    "sumneko_lua",
    "bashls",
    "dockerls",
    "jsonls",
    "marksman",
    "pyright",
    "solargraph",
    "taplo",
    "yamlls",
  }
}

local lspconfig = require("lspconfig")
lspconfig.sumneko_lua.setup {
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
