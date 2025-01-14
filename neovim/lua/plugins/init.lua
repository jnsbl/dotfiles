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
  -- Appearance
  "bradcush/nvim-base16",
  -- "RRethy/nvim-base16",
  "tinted-theming/tinted-vim",
  "kyazdani42/nvim-web-devicons",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "tinted-theming/tinted-vim",
    }
  },
  {
    "sontungexpt/sttusline",
    branch = "table_version",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = { "BufEnter" },
    config = function()
      require("sttusline").setup()
    end,
  },
  -- "goolord/alpha-nvim",
  "lukas-reineke/indent-blankline.nvim",
  "kevinhwang91/nvim-bqf",

  -- Utilities
  "nvim-lua/plenary.nvim",
  "famiu/bufdelete.nvim",
  "jghauser/mkdir.nvim",
  "nkakouros-original/numbers.nvim",
  "norcalli/nvim-colorizer.lua",
  -- use "gennaro-tedesco/nvim-peekup"
  "numToStr/Comment.nvim",
  {"phaazon/hop.nvim", branch = "v2"},
  "nacro90/numb.nvim",
  "lewis6991/gitsigns.nvim",
  "nvim-lua/popup.nvim",
  "MunifTanjim/nui.nvim",
  "vim-scripts/ReplaceWithRegister",
  "kyazdani42/nvim-tree.lua",
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Syntax
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  "kylechui/nvim-surround",
  "m-demare/hlargs.nvim",
  "dag/vim-fish",
  "ron-rs/ron.vim",

  -- Language support
  -- {"roxma/nvim-yarp", { build = "pip install -r requirements.txt" }},
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },

  -- Fuzzy-finding and searching
  "BurntSushi/ripgrep",
  {"nvim-telescope/telescope.nvim", branch = "0.1.x"},
  "jvgrootveld/telescope-zoxide",
  "gelguy/wilder.nvim",
  "kevinhwang91/nvim-hlslens",
  -- {
  --   "junegunn/fzf.vim",
  --   dependencies = { "junegunn/fzf" },
  -- },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- File-type specific
  "ellisonleao/glow.nvim",

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- Code completion and snippets
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/nvim-cmp"
})

-- Appearance
-- require("plugins.base16-nvim")
-- require("plugins.nvim-base16")
require("plugins.tinted-vim")
require("plugins.nvim-web-devicons")
-- require("plugins.lualine-nvim")
-- require("plugins.alpha-nvim")
-- require("plugins.indent-blankline-nvim")

-- Utilities
require("plugins.numbers-nvim")
require("plugins.nvim-colorizer")
require("plugins.comment-nvim")
require("plugins.hop-nvim")
require("plugins.numb-nvim")
require("plugins.gitsigns-nvim")
require("plugins.nvim-tree")
require("plugins.snacks-nvim")

-- Syntax
require("plugins.nvim-surround")
require("plugins.hlargs-nvim")

-- Fuzzy-finding and searching
require("plugins.telescope-nvim")
require("plugins.wilder-nvim")
require("plugins.nvim-hlslens")
-- require("plugins.fzf-vim")
require("plugins.fzf-lua")

-- File-type specific
require("plugins.glow-nvim")

-- LSP
require("plugins.lsp-mason-nvim")

-- Code completion and snippets
require("plugins.nvim-cmp")
