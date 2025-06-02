-- ============================================================================
-- Neovim Lazy Plugin Manager Configuration
-- ============================================================================

-- Bootstrap lazy.nvim plugin manager
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

-- ============================================================================
-- Plugin Specifications
-- ============================================================================

return require("lazy").setup({
  -- Git configuration for SSH cloning
  git = {
    url_format = "git@github.com:%s.git"
  },

  -- ==========================================================================
  -- UI & THEMING
  -- ==========================================================================
  
  -- Monokai Pro colorscheme
  {
    "loctvl842/monokai-pro.nvim",
    name = "monokai-pro",
    priority = 1000,
    config = function()
      require("plugins.colorscheme")
    end,
  },

  -- Which-key: Show keybinding hints
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("plugins.which-key")
    end,
  },

  -- ==========================================================================
  -- FILE NAVIGATION & MANAGEMENT
  -- ==========================================================================
  
  -- File tree explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.nvim-tree")
    end,
  },

  -- Fuzzy finder and picker
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("plugins.telescope")
    end,
  },

  -- ==========================================================================
  -- LANGUAGE SERVER PROTOCOL (LSP)
  -- ==========================================================================
  
  -- LSP configuration and management
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lsp")
    end,
  },

  -- ==========================================================================
  -- 42 SCHOOL SPECIFIC TOOLS
  -- ==========================================================================
  
  -- C/C++ formatter following 42 School norm
  {
    "Diogo-ss/42-C-Formatter.nvim",
    cmd = "CFormat42",
    ft = { "c", "cpp", "h", "hpp" },
    config = function()
      require("plugins.formatter42")
    end,
  },

  -- 42 School header generator
  {
    "42Paris/42header",
    lazy = false,
    config = function()
      require("plugins.header42")
    end,
  },

  -- ==========================================================================
  -- SYNTAX & EDITING ENHANCEMENTS
  -- ==========================================================================
  
  -- Treesitter: Advanced syntax highlighting and parsing
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate", -- Auto-update parsers
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- Mini.nvim: Collection of minimal useful plugins
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.mini")
    end,
  },

  -- Auto-close brackets, quotes, etc.
  {
    "m4xshen/autoclose.nvim",
    event = "InsertEnter",
    config = function()
      require("plugins.autoclose")
    end,
  },
})
