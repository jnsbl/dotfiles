local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  ---------------------------------------------------- Appearance

  "bradcush/nvim-base16",
  require("plugins/tinted-vim"),
  require("plugins/nvim-web-devicons"),
  require("plugins/sttusline"),
  require("plugins/indent-blankline-nvim"),
  "kevinhwang91/nvim-bqf",

  ---------------------------------------------------- Utilities

  "famiu/bufdelete.nvim",
  "jghauser/mkdir.nvim",
  require("plugins/numbers-nvim"),
  require("plugins/nvim-colorizer"),
  require("plugins/comment-nvim"),
  require("plugins/numb-nvim"),
  require("plugins/gitsigns-nvim"),
  "vim-scripts/ReplaceWithRegister",
  require("plugins/nvim-tree"),
  require("plugins/snacks-nvim"),
  require("plugins/mini-splitjoin"),
  require("plugins/mini-files"),
  require("plugins/mini-pairs"),

  ---------------------------------------------------- Syntax

  require("plugins/nvim-treesitter"),
  require("plugins/mini-surround"),
  require("plugins/mini-ai"),
  "dag/vim-fish",
  "ron-rs/ron.vim",

  ---------------------------------------------------- Language support

  require("plugins/lazydev-nvim"),
  require("plugins/haskell-tools-nvim"),

  ---------------------------------------------------- Fuzzy-finding and searching

  "BurntSushi/ripgrep",
  require("plugins/wilder-nvim"),
  require("plugins/nvim-hlslens"),
  require("plugins/fzf-lua"),

  ---------------------------------------------------- File-type specific

  require("plugins/glow-nvim"),

  ---------------------------------------------------- LSP

  require("plugins/nvim-lspconfig"),

  ---------------------------------------------------- Code completion, snippets

  require("plugins/nvim-cmp"),

})
