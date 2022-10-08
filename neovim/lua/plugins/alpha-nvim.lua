local startify = require("alpha.themes.startify")
startify.section.mru_cwd.val = {{type = "padding", val = 0}}
startify.section.bottom_buttons.val = {
  startify.button("v", "Neovim settings", ":e ~/.config/nvim/lua/general.lua<CR>"),
  startify.button("p", "Neovim plugins", ":e ~/.config/nvim/lua/plugins/init.lua<CR>"),
  startify.button("m", "Neovim keymap", ":e ~/.config/nvim/lua/keymap.lua<CR>"),
  startify.button("t", "Qtile config", ":e ~/.config/qtile/config.py<CR>"),
  startify.button("w", "AwesomeWM config", ":e ~/.config/awesome/rc.lua<CR>"),
  startify.button("q", "Quit Neovim" , ":qa<CR>"),
}

local alpha = require("alpha")
alpha.setup(startify.config)
