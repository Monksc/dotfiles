local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Set colors
local active_color = {
    color = beautiful.topbar_fg_normal
}

local background_color = beautiful.topbar_bg

local ram_bar = wibox.widget {
    max_value = 100,
    value = 50,
    forced_height = 30,
    forced_width = 350,
    shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 16) end,
    bar_shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 14) end,
    color = active_color,
    background_color = background_color,
    border_width = 2,
    border_color = "#000000",
    widget = wibox.widget.progressbar
}

local tt = awful.tooltip {
    text = "RAM Usage: Loading ...",
    visible = false,
}
tt.bg = beautiful.bg_normal

local update_interval = 1

-- local ram_script = [[
--   sh -c "
--   free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
--   "]]
local ram_script = [[
  sh -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $3, $2}'
  "]]

awesome.connect_signal("signals::ram", function(used, total)
    local used_ram_percentage = (used / total) * 100
    ram_bar.value = used_ram_percentage
    -- tt.text = "RAM Usage: " .. used .. "MiB"
    -- tt.text = "RAM Usage: " .. (10*(used_ram_percentage // 10)) .. "%"
    tt.text = "RAM Usage: " .. (((10*used) // 1000) / 10) .. "GiB"
end)

tt:add_to_object(ram_bar)

return ram_bar
