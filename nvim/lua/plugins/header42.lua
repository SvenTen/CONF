-- ============================================================================
-- 42 School Header Configuration
-- Automatically inserts 42 School standard headers
-- ============================================================================

-- Keymap for inserting standard header
vim.api.nvim_set_keymap("n", "<F1>", ":Stdheader<CR>", { 
  desc = "Insert 42 standard header",
  noremap = true, 
  silent = true 
})

