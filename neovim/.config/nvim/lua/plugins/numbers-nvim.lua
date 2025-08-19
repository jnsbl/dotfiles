return {
  "nkakouros-original/numbers.nvim",
  config = function()
    local numbers = require("numbers")
    numbers.setup {
      excluded_filetypes = {
        'nerdtree',
        'unite',
        -- etc
      }
    }
  end,
}
