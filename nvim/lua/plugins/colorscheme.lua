-- ============================================================================
-- Monokai Pro Colorscheme Configuration
-- ============================================================================

local monokai = require("monokai-pro")

monokai.setup({
  transparent_background = true,
  terminal_colors = true,
  devicons = true,
  styles = {
    comment = { italic = true },
    keyword = { italic = true },
    type = { italic = true },
    storageclass = { italic = true },
    structure = { italic = true },
    parameter = { italic = true },
    annotation = { italic = true },
    tag_attribute = { italic = true },
  },
  filter = "pro",
  inc_search = "background",
  background_clear = {
    "float_win",
    "toggleterm",
    "telescope",
    "which-key",
    "renamer",
    "notify",
    "nvim-tree",
    "bufferline",
    "treesitter-context",
    "neo-tree",
  },
})

-- Apply the colorscheme
vim.cmd("colorscheme monokai-pro")


