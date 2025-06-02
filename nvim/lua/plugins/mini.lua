-- ============================================================================
-- Mini.nvim Configuration
-- Collection of minimal useful plugins
-- ============================================================================

-- Text objects (enhanced a/i text objects)
require("mini.ai").setup({ 
  n_lines = 500 
})

-- Surrounding text manipulation (add, delete, replace surroundings)
require("mini.surround").setup()

-- Minimal statusline
local statusline = require("mini.statusline")
statusline.setup({ 
  use_icons = vim.g.have_nerd_font 
})

-- Customize location format
statusline.section_location = function()
  return "%2l:%-2v"
end
