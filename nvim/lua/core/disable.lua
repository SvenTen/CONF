
-- disable.lua - Learn Vim the Hard Way
-- This file disables common crutches and forces proper Vim usage

-- =============================================================================
-- Helper function to notify when bad habits are used
-- =============================================================================
local function show_reminder(bad_habit, good_alternative)
  vim.notify("BAD HABIT: " .. bad_habit .. " | USE: " .. good_alternative, vim.log.levels.WARN)
end

-- =============================================================================
-- Disable single hjkl usage in normal mode unless used with a count
-- =============================================================================
local function disable_single_hjkl(key, direction)
  vim.keymap.set('n', key, function()
    if vim.v.count == 0 then
      show_reminder("Single " .. key, "Use count+" .. key .. " or " .. direction)
      return ""
    else
      return key
    end
  end, { noremap = true, expr = true, silent = false })
end

disable_single_hjkl('h', 'b/B or F/T')
disable_single_hjkl('j', 'Ctrl+d or /search')
disable_single_hjkl('k', 'Ctrl+u or ?search')
disable_single_hjkl('l', 'w/e or f/t')

-- Visual mode hjkl
local visual_keys = {
  h = "Use text objects: iw, ap, i}, etc.",
  j = "Use text objects or count+j",
  k = "Use text objects or count+k",
  l = "Use text objects: aw, a), a], etc."
}

for key, msg in pairs(visual_keys) do
  vim.keymap.set('v', key, function() show_reminder("Visual " .. key, msg) end, { noremap = true, silent = false })
end

-- =============================================================================
-- Disable arrow keys in all modes
-- =============================================================================
local arrows = { '<Up>', '<Down>', '<Left>', '<Right>' }
for _, key in ipairs(arrows) do
  for _, mode in ipairs({ 'n', 'i', 'v' }) do
    vim.keymap.set(mode, key, '<Nop>', { noremap = true, silent = true })
  end
end

-- =============================================================================
-- Disable page up/down, home/end, delete/backspace keys
-- =============================================================================
local crutch_keys = {
  ['<PageUp>'] = 'Ctrl+u or Ctrl+b',
  ['<PageDown>'] = 'Ctrl+d or Ctrl+f',
  ['<Home>'] = '^ or 0',
  ['<End>'] = '$',
  ['<Delete>'] = 'x, X, dd',
  ['<BS>'] = 'x or X'
}

for key, alternative in pairs(crutch_keys) do
  for _, mode in ipairs({ 'n', 'i', 'v' }) do
    vim.keymap.set(mode, key, '<Nop>', { noremap = true, silent = true })
  end
  if vim.tbl_contains({ 'n' }, key) then
    vim.keymap.set('n', key, function() show_reminder(key, alternative) end, { noremap = true, silent = false })
  end
end

-- =============================================================================
-- Disable Ctrl+arrow key navigation
-- =============================================================================
for _, key in ipairs({ '<C-Up>', '<C-Down>', '<C-Left>', '<C-Right>' }) do
  for _, mode in ipairs({ 'n', 'i' }) do
    vim.keymap.set(mode, key, '<Nop>', { noremap = true, silent = true })
  end
end

-- =============================================================================
-- Disable other crutches
-- =============================================================================
vim.keymap.set('n', 'Q', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-a>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-e>', '<Nop>', { noremap = true, silent = true })

-- =============================================================================
-- Force alternative better habits
-- =============================================================================
vim.keymap.set('n', 'x', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', 's', '<Nop>', { noremap = true, silent = true })

vim.keymap.set('n', 'gj', 'j', { noremap = true, silent = true })
vim.keymap.set('n', 'gk', 'k', { noremap = true, silent = true })

vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- =============================================================================
-- GUI options (if in a GUI Vim/Neovim)
-- =============================================================================
vim.opt.mouse = ""
vim.opt.visualbell = false
vim.opt.errorbells = false
vim.opt.cmdheight = 1

pcall(function()
  vim.opt.guioptions:remove('T')  -- Toolbar
  vim.opt.guioptions:remove('r')  -- Right scrollbar
  vim.opt.guioptions:remove('L')  -- Left scrollbar
  vim.opt.guioptions:remove('m')  -- Menu bar
end)

-- =============================================================================
-- Startup message
-- =============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      print("🔥 SMART HARD MODE ENABLED 🔥")
      print("- Single hjkl disabled (counts required)")
      print("- Arrows, mouse, and crutches removed")
    end, 100)
  end
})
