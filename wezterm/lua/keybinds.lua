local wezterm = require("wezterm")
local keys = {
  -- TAB MANAGEMENT (using homerow keys with mnemonics)
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") }, -- 't' for tab
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) }, -- 'w' for close (like web browsers)
  { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
  
  -- PANE MANAGEMENT (using available homerow keys)
  { key = "u", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- 'u' for horizontal split (right side of homerow)
  { key = "y", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- 'y' for vertical split (upper homerow)
  { key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) }, -- 'x' for close/exit
	
  -- PANE NAVIGATION using ALT + Colemak-DH nav keys (neio = left/down/up/right)
  { key = "n", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },   -- 'n' left
  { key = "e", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },   -- 'e' down
  { key = "i", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },     -- 'i' up
  { key = "o", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },  -- 'o' right
  
  -- Alternative arrow key navigation (still works)
  { key = "LeftArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "UpArrow",    mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "DownArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
  
  -- PANE RESIZING using Colemak-DH nav keys with CTRL|ALT (avoiding conflicts)
  { key = "n", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },   -- 'n' resize left
  { key = "e", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },   -- 'e' resize down
  { key = "i", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },     -- 'i' resize up
  { key = "o", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },  -- 'o' resize right
  
  -- COPY/PASTE (keeping familiar shortcuts)
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  
  -- RELOAD CONFIG
  { key = "R", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
}

return {
  keys = keys
}
