require("snacks").setup({
  bigfile = { enabled = false },
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      { section = "startup" },
    },
    wo = {
      number = false,
    },
  },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

vim.api.nvim_create_autocmd("TabNewEntered", {
  callback = function()
    Snacks.dashboard({ buf = 0, win = 0 })
  end,
})
