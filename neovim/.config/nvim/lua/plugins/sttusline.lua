return {
  "sontungexpt/sttusline",
  branch = "table_version",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufEnter" },
  config = function()
    require("sttusline").setup()
  end,
}
