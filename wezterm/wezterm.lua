local appearance = require("lua.appearance")
local keybinds = require("lua.keybinds")
require("lua.startup")

-- Merge all config tables into one
local config = {}

for k, v in pairs(appearance) do config[k] = v end
for k, v in pairs(keybinds) do config[k] = v end

return config
