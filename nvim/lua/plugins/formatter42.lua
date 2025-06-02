-- ============================================================================
-- 42 School C/C++ Formatter Configuration
-- Formats C/C++ code according to 42 School coding standards
-- ============================================================================

local formatter = require("42-formatter")

formatter.setup({
  formatter = "c_formatter_42",
  filetypes = {
    c = true,
    h = true,
    cpp = true,
    hpp = true,
  },
})

-- ============================================================================
-- Keymaps
-- ============================================================================

vim.api.nvim_set_keymap("n", "<F2>", ":CFormat42<CR>", { 
  desc = "Format with 42 C formatter",
  noremap = true, 
  silent = true 
})
