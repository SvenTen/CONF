-- ============================================================================
-- Autoclose Configuration
-- Automatically close brackets, quotes, and other paired characters
-- ============================================================================

require("autoclose").setup({
  keys = {
    -- Opening brackets
    ["("] = { escape = false, close = true, pair = "()" },
    ["["] = { escape = false, close = true, pair = "[]" },
    ["{"] = { escape = false, close = true, pair = "{}" },

    -- Closing brackets
    [")"] = { escape = true, close = false, pair = "()" },
    ["]"] = { escape = true, close = false, pair = "[]" },
    ["}"] = { escape = true, close = false, pair = "{}" },

    -- Quotes
    ['"'] = { escape = true, close = true, pair = '""' },
    ["'"] = { escape = true, close = true, pair = "''" },
    ["`"] = { escape = true, close = true, pair = "``" },
  },
  options = {
    disabled_filetypes = { "text", "gitcommit" },
    disable_when_touch = true,
    touch_regex = "[%w(%[{]",
    pair_spaces = true,
    auto_indent = true,
    disable_command_mode = false,
  },
})
