return {
  'echasnovski/mini.files',
  version = false,
  config = function()
    require("mini.files").setup()

    local keymap = vim.keymap.set

    keymap("n", "<space>f",  function()
      if not MiniFiles.close() then MiniFiles.open() end
    end,
    { desc = "Mini [F]iles" })
  end,
}
