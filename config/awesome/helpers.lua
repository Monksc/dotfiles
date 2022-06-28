-- Thanks For JavaCafe01

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local naughty = require("naughty")

local helpers = {}

function helpers.volume_control(step)
    local cmd
    if step == 0 then
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    else
        sign = step > 0 and "+" or ""
        cmd =
            "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ " ..
                sign .. tostring(step) .. "%"
    end
    awful.spawn.with_shell(cmd)
end

function helpers.colorize_text(txt)
    return "<span>" .. txt .. "</span>"
end

helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

function helpers.add_hover_cursor(w, hover_cursor)
    local original_cursor = "left_ptr"

    w:connect_signal("mouse::enter", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = hover_cursor
        end
    end)

    w:connect_signal("mouse::leave", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = original_cursor
        end
    end)
end

function helpers.modkey_released_event_handler(handle_keys, event_modkey_released)
    if exit_screen_grabber then
        return
    end

    exit_screen_grabber = awful.keygrabber.run(
        function(mod, key, event)
            if event == 'release' and key == 'Super_L' then
                event_modkey_released()
                modkey_released_timer = nil
                awful.keygrabber.stop(exit_screen_grabber)
                exit_screen_grabber = nil
            else
                handle_keys(mod, key, event)
            end
        end
    )
end

function helpers.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. helpers.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

return helpers
