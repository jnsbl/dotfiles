local startify = require("alpha.themes.startify")
startify.section.mru_cwd.val = {{type = "padding", val = 0}}
startify.section.bottom_buttons.val = {
  startify.button("v", "Neovim settings", ":e ~/.config/nvim/lua/general.lua<CR>"),
  startify.button("p", "Neovim plugins", ":e ~/.config/nvim/lua/plugins/init.lua<CR>"),
  startify.button("m", "Neovim keymap", ":e ~/.config/nvim/lua/keymap.lua<CR>"),
  startify.button("H", "Neovim homepage", ":e ~/.config/nvim/lua/plugins/alpha-nvim.lua<CR>"),
  startify.button("t", "Qtile config", ":e ~/.config/qtile/config.py<CR>"),
  startify.button("w", "AwesomeWM config", ":e ~/.config/awesome/rc.lua<CR>"),
  startify.button("L", "LeftWM config", ":e ~/.config/leftwm/config.ron<CR>"),
  startify.button("M", "XMonad config", ":e ~/.config/xmonad/xmonad.hs<CR>"),
  startify.button("B", "Polybar config", ":e ~/.config/polybar/config.ini<CR>"),
  startify.button("S", "Ranger scope", ":e ~/.config/ranger/scope.sh<CR>"),
  startify.button("F", "Fish config", ":e ~/.config/fish/config.fish<CR>"),
  startify.button("D", "Dotfiles config", ":e ~/code/hobby/dotfiles/install.conf.yaml<CR>"),
  startify.button("q", "Quit Neovim" , ":qa<CR>"),
}

local alpha = require("alpha")
alpha.setup(startify.config)
