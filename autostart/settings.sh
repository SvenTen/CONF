#!/bin/bash

# Set workspace switching keybindings
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>n']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>e']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>i']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>,']"


# Disable animations
dconf write /org/gnome/desktop/interface/enable-animations false
