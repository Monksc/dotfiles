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

local cpu_bar = wibox.widget {
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
    text = "CPU Usage: Loading ...",
    visible = false,
}
tt.bg = beautiful.bg_normal

awesome.connect_signal("signals::cpu", function(value)
    cpu_bar.value = value
    tt.text = "CPU Usage: " .. value .. "%"
end)

tt:add_to_object(cpu_bar)

return cpu_bar
