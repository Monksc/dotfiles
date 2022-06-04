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

local muted_color = {
    color = "#cc5757"
}
local active_background_color = "#ffffff5f"
local muted_background_color = "#ffffff5f"

local volume_bar = wibox.widget {
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
    text = "Volume: Loading ...",
    visible = false,
}
tt.bg = beautiful.bg_normal

function update_volume()
    local handle = io.popen("amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'")
    local result = handle:read("*a")
    handle:close()

    local handle_mute = io.popen("amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'")
    local result_mute = handle_mute:read("*a")
    handle_mute:close()

    local volume = tonumber(result:sub(1, -3))
    tt.text = "Volume: " .. volume .. "%"
    local bg_color
    local fill_color
    if result_mute == "off\n" then
        fill_color = muted_color
        bg_color = muted_background_color
    else
        fill_color = active_color
        bg_color = active_background_color
    end
    volume_bar.color = fill_color
    volume_bar.background_color = bg_color
    volume_bar.value = volume
end

local watch = require("awful.widget.watch")
watch("amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'", 60,
    function(widget, stdout)
        update_volume()
    end
, volume_bar)
update_volume()

awesome.connect_signal("volume_refresh", function()
    update_volume()
end)

-- awesome.connect_signal("signals::volume", function(volume, muted)
--     local bg_color
--     local fill_color
--     if muted then
--         fill_color = muted_color
--         bg_color = muted_background_color
--     else
--         fill_color = active_color
--         bg_color = active_background_color
--     end
--     volume_bar.color = fill_color
--     volume_bar.background_color = bg_color
--     volume_bar.value = 100 * volume
-- end)

tt:add_to_object(volume_bar)
return volume_bar
