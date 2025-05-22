local statusline = require("mini.statusline")

-- Setup mini.ai for text objects
require("mini.ai").setup({ n_lines = 500 })

-- Setup mini.surround for surrounding text
require("mini.surround").setup()

-- Setup minimal statusline
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
  return "%2l:%-2v"
end
