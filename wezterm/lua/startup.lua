
local wezterm = require("wezterm")

-- Function to create the 3-pane layout with side padding
local function setup_centered_layout(pane, start_nvim)
  start_nvim = start_nvim or false
  
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

  -- Step 3: run Neovim in the center pane if requested
  if start_nvim then
    center:send_text("nvim\n")
  end
  
  return center
end

-- Keep track of tabs that have been processed
local processed_tabs = {}

-- Handle initial startup
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {
    workspace = "CenteredNvim",
    args = { "zsh" },
  })

  window:gui_window():toggle_fullscreen()
  wezterm.sleep_ms(100)

  setup_centered_layout(pane, true)
  
  -- Mark startup as done and track the initial tab
  processed_tabs["startup_done"] = true
  processed_tabs[tab:tab_id()] = true
end)

-- Handle new tab creation by hooking into tab activation
wezterm.on("update-status", function(window, pane)
  -- Check if we have a new tab with only one pane (indicating a fresh tab)
  local tab = window:active_tab()
  local tab_id = tab:tab_id()
  
  -- If this tab hasn't been processed and has only one pane
  if not processed_tabs[tab_id] and #tab:panes() == 1 then
    local active_pane = tab:active_pane()
    
    -- Only setup layout for non-startup tabs
    if processed_tabs["startup_done"] then
      setup_centered_layout(active_pane, false)
    end
    
    processed_tabs[tab_id] = true
  end
end)
