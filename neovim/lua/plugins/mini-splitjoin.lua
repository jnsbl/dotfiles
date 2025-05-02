return {
  'echasnovski/mini.splitjoin',
  version = false,
  config = function()
    require("mini.splitjoin").setup({
      mappings = {
        split = 'sj',
        join = 'sk',
      }
    })
  end,
}
