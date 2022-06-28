local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')
local sounds = require('sounds')

-- Set colors
local active_color = {
    color = beautiful.topbar_fg_normal
}

local low_battery_color = {
    color = beautiful.topbar_fg_warning
}
local normal_battery_color = {
    color = beautiful.topbar_fg_normal
}
local charging_color = {
    color = beautiful.topbar_fg_success
}
local active_background_color = beautiful.topbar_bg
local muted_background_color = beautiful.topbar_bg

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

function sendout_lowbattery_notif(old_value, new_value, marked_value)
    if new_value <= marked_value and old_value > marked_value then
        naughty.notify({
            title = "Low Battery",
            message = "Battery percentage is at " .. new_value .. "%",
            timeout = 20
        })
        awful.spawn('mpv '.. sounds.mp3.notification)
    end
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

    sendout_lowbattery_notif(battery_bar.value, value, 20)
    sendout_lowbattery_notif(battery_bar.value, value, 10)
    sendout_lowbattery_notif(battery_bar.value, value, 5)
    sendout_lowbattery_notif(battery_bar.value, value, 3)

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
