
local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {
    workspace = "CenteredNvim",
    args = { "zsh" },
  })

  window:gui_window():toggle_fullscreen()
  wezterm.sleep_ms(100)

  -- Step 1: split RIGHT of first pane (80% to right, so left is 20%)
  local left = pane
  local remainder = left:split({
    direction = "Right",
    size = 0.80, -- 80% to the right side
    args = { "zsh" },
  })

  -- Step 2: split LEFT of remainder (3/4 of 80% = 60% of screen)
  local center = remainder:split({
    direction = "Left",
    size = 0.75, -- 75% of 80% = 60% total
    args = { "zsh" },
  })

  -- Step 3: run Neovim in the center pane
  center:send_text("nvim\n")
end)
