require("config.remote_clipboard").setup()
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
local opt = vim.opt

-- ----------------------------------------------------------------------------
-- Options - Indents and Tabs

opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.expandtab = true
opt.relativenumber = false

-- ----------------------------------------------------------------------------
-- Options - Diagnostic

-- disable diagnostic by default
vim.diagnostic.enable(false)
