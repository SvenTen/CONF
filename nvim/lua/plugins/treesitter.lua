-- ============================================================================
-- Treesitter Configuration
-- Advanced syntax highlighting and language parsing
-- ============================================================================

require("nvim-treesitter.configs").setup({
  -- Ensure these language parsers are installed
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "diff",
    "html",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
  },
  
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
  
  -- Syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "ruby" },
  },
  
  -- Indentation based on treesitter
  indent = {
    enable = true,
    disable = { "ruby" },
  },
})
