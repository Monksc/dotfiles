local awful = require('awful')
local conf = awful.util.getdir('config')
local icon = conf .. 'sounds/'

local icons = {}

icons.mp3 = {
   notification = icon .. "notification.mp3",
}

return icons
