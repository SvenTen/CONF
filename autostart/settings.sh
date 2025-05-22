#!/bin/bash

# Set workspace switching keybindings
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>q']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>w']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>e']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>r']"

# Disable animations
dconf write /org/gnome/desktop/interface/enable-animations false
