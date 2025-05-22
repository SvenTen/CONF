
local wezterm = require("wezterm")

local keys = {
  -- TAB MANAGEMENT
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

  -- PANE MANAGEMENT
  { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "q", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	
  -- PANE NAVIGATION using ALT + Arrow Keys
  { key = "LeftArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "UpArrow",    mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "DownArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },

  -- PANE RESIZING
  { key = "H", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
  { key = "L", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

  -- COPY/PASTE
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

  -- RELOAD CONFIG
  { key = "R", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
}

return {
  keys = keys
}
