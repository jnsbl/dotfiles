vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
  use "savq/paq-nvim"                  -- Let Packer manage itself

  -- Appearance
  use "bradcush/base16-nvim"
  use "RRethy/nvim-base16"
  use "kyazdani42/nvim-web-devicons"
  use "nvim-lualine/lualine.nvim"
  use "goolord/alpha-nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "kevinhwang91/nvim-bqf"

  -- Utilities
  use "nvim-lua/plenary.nvim"
  use "famiu/bufdelete.nvim"
  use "jghauser/mkdir.nvim"
  use "nkakouros-original/numbers.nvim"
  use "norcalli/nvim-colorizer.lua"
  -- use "gennaro-tedesco/nvim-peekup"
  use "numToStr/Comment.nvim"
  use {"phaazon/hop.nvim", branch = "v2"}
  use "nacro90/numb.nvim"
  use "lewis6991/gitsigns.nvim"
  use "nvim-lua/popup.nvim"
  use "MunifTanjim/nui.nvim"
  use "vim-scripts/ReplaceWithRegister"
  use "kyazdani42/nvim-tree.lua"

  -- Syntax
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "kylechui/nvim-surround"
  use "m-demare/hlargs.nvim"
  use "dag/vim-fish"

  -- Language support
  use {"roxma/nvim-yarp", { run = "pip install -r requirements.txt" }}

  -- Fuzzy-finding and searching
  use "BurntSushi/ripgrep"
  use {"nvim-telescope/telescope.nvim", branch = "0.1.x"}
  use "jvgrootveld/telescope-zoxide"
  use "gelguy/wilder.nvim"
  use "kevinhwang91/nvim-hlslens"

  -- File-type specific
  use "ellisonleao/glow.nvim"

  -- LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"

  -- Code completion and snippets
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/nvim-cmp"
end)

-- Appearance
require("plugins.base16-nvim")
require("plugins.nvim-base16")
require("plugins.nvim-web-devicons")
require("plugins.lualine-nvim")
require("plugins.alpha-nvim")
require("plugins.indent-blankline-nvim")

-- Utilities
require("plugins.numbers-nvim")
require("plugins.nvim-colorizer")
require("plugins.comment-nvim")
require("plugins.hop-nvim")
require("plugins.numb-nvim")
require("plugins.gitsigns-nvim")
require("plugins.nvim-tree")

-- Syntax
require("plugins.nvim-surround")
require("plugins.hlargs-nvim")

-- Fuzzy-finding and searching
require("plugins.telescope-nvim")
require("plugins.wilder-nvim")
require("plugins.nvim-hlslens")

-- File-type specific
require("plugins.glow-nvim")

-- LSP
require("plugins.lsp-mason-nvim")

-- Code completion and snippets
require("plugins.nvim-cmp")
