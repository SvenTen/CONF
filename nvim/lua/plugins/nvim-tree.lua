-- ============================================================================
-- Nvim-Tree Configuration
-- File explorer tree for navigation and file management
-- ============================================================================

-- Disable netrw to avoid conflicts
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvim_tree = require("nvim-tree")

nvim_tree.setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = true,
      },
    },
  },
})

-- ============================================================================
-- Keymaps
-- ============================================================================

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { 
  desc = "Toggle file explorer",
  noremap = true, 
  silent = true 
})

vim.keymap.set("n", "<leader>fe", ":NvimTreeFocus<CR>", { 
  desc = "Focus file explorer",
  noremap = true, 
  silent = true 
})
