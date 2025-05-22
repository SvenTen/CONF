local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["d"] = function(prompt_bufnr)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local selected = action_state.get_selected_entry()
            local bufnr = selected.bufnr

            if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 then
              vim.notify("Can't delete the last buffer", vim.log.levels.WARN)
              actions.close(prompt_bufnr)
              return
            end

            vim.api.nvim_buf_delete(bufnr, { force = true })

            vim.cmd([[
              Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy
            ]])
          end,
        },
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")

vim.keymap.set("n", "<leader>sa", function()
  local home_dir = vim.fn.expand("$HOME/CODE")
  builtin.find_files({
    cwd = home_dir,
    previewer = false,
  })
end, { desc = "[S]earch [A]ll files /Projects" })

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>", { desc = "[ ] Find existing buffers" })

-- Current buffer fuzzy find with dropdown theme
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Grep only open files
vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })

-- Search Neovim config
vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- Toggle Explorer
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("NvimTreeToggle")
end, { desc = "[S]earch toggle [E]xplorer" })

-- Focus Explorer
vim.keymap.set("n", "<leader>E", function()
  vim.cmd("NvimTreeFocus")
end, { desc = "[S]earch focus [E]xplorer" })
