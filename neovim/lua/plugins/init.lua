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

  {"bradcush/nvim-base16"},
  {
    "tinted-theming/tinted-vim",
    config = function()
      require("plugins.tinted-vim")
    end,
  },
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.nvim-web-devicons")
    end,
  },
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
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline-nvim")
    end,
  },
  {"kevinhwang91/nvim-bqf"},

  ---------------------------------------------------- Utilities

  {"nvim-lua/plenary.nvim"},
  {"famiu/bufdelete.nvim"},
  {"jghauser/mkdir.nvim"},
  {
    "nkakouros-original/numbers.nvim",
    config = function()
      require("plugins.numbers-nvim")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.nvim-colorizer")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment-nvim")
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("plugins.hop-nvim")
    end,
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("plugins.numb-nvim")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns-nvim")
    end,
  },
  {"nvim-lua/popup.nvim"},
  {"MunifTanjim/nui.nvim"},
  {"vim-scripts/ReplaceWithRegister"},
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("plugins.snacks-nvim")
    end,
  },

  ---------------------------------------------------- Syntax

  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {
    "kylechui/nvim-surround",
    config = function()
      require("plugins.nvim-surround")
    end,
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("plugins.hlargs-nvim")
    end,
  },
  {"dag/vim-fish"},
  {"ron-rs/ron.vim"},

  ---------------------------------------------------- Language support

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
  {
    "prettier/vim-prettier",
    ft = { "javascrit", "typescript", "css", "scss", "json", "graphql", "markdown", "vue", "yaml", "html" },
  },

  ---------------------------------------------------- Fuzzy-finding and searching

  {"BurntSushi/ripgrep"},
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("plugins.telescope-nvim")
    end,
  },
  {"jvgrootveld/telescope-zoxide"},
  {
    "gelguy/wilder.nvim",
    config = function()
      require("plugins.wilder-nvim")
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("plugins.nvim-hlslens")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.fzf-lua")
    end,
  },

  ---------------------------------------------------- File-type specific

  {
    "ellisonleao/glow.nvim",
    config = function()
      require("plugins.glow-nvim")
    end,
  },

  ---------------------------------------------------- LSP

  {
    "williamboman/mason.nvim",
    -- config = function()
    --   require("plugins.lsp-mason-nvim")
    -- end,
  },
  {"williamboman/mason-lspconfig.nvim"},
  {"neovim/nvim-lspconfig"},

  -- ------------------------------------------------- Code completion and snippets

  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-nvim-lsp-signature-help"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-cmdline"},
  {"L3MON4D3/LuaSnip"},
  {"saadparwaiz1/cmp_luasnip"},
  {
    "hrsh7th/nvim-cmp",
    -- config = function()
    --   require("plugins.nvim-cmp")
    -- end,
  }
})

require("plugins.lsp-cmp-snip")
