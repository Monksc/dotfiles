local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')

-- Set colors
local active_color = {
    color = "#ffffff"
}
local muted_color = active_color

local low_battery_color = {
    color = "#cc5757"
}
local normal_battery_color = {
    color = "#ffffff"
}
local charging_color = {
    color = "#8dad88"
}
local active_background_color = "#ffffff5f"
local muted_background_color = "#ffffff5f"

local battery_bar = wibox.widget {
    max_value = 100,
    value = 50,
    shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 16) end,
    bar_shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 14) end,
    color = active_color,
    background_color = active_background_color,
    border_width = 2,
    border_color = "#000000",
    widget = wibox.widget.progressbar,
}

local tt = awful.tooltip {
    text = "Battery tooltip: Loading ...",
    visible = false,
}
tt.bg = beautiful.bg_normal

function update_tooltip()
    local handle = io.popen("acpi -i | rg '([0-9]{2}:){2}[0-9]{2}' | awk '{print substr($0, 12)}'")
    local result = handle:read("*a")
    handle:close()

    tt.text = result:sub(1, -2)
end

function update_battery()
    local handle = io.popen('cat /sys/class/power_supply/BAT1/capacity')
    local result = handle:read("*a")
    handle:close()
    local value = tonumber(result)

    local handle_status = io.popen('cat /sys/class/power_supply/BAT1/status')
    local result_status = handle_status:read("*a")
    handle_status:close()

    local fill_color
    local bg_color
    if result_status == 'Charging\n' or value >= 99 then
        fill_color = charging_color
        bg_color = active_background_color
    elseif value < 20 then
        fill_color = low_battery_color
        bg_color = active_background_color
    else
        fill_color = normal_battery_color
        bg_color = active_background_color
    end

    battery_bar.value = value
    battery_bar.color = fill_color
    battery_bar.background_color = bg_color
end

local watch = require("awful.widget.watch")
watch("acpi -i", 10,
    function(widget, stdout)
        update_battery()
        update_tooltip()
    end
, battery_bar)


tt:add_to_object(battery_bar)

return battery_bar
