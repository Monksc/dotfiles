local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local icons = require('icons')
local beautiful = require("beautiful")
local helpers = require("helpers")
local menubar = require("menubar")

require("awful.autofocus")

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

local bar_color = '#013192'
local background_color = '#7291de'
local border_color = '#010101'

alertbox = {}

function alertbox.createbutton(text, icon, onclick)
    local button = wibox.widget {
        {
            image = icon,
            forced_height = 70,
            forced_width = 70,
            halign  = 'center',
            valign = 'center',
            widget = wibox.widget.imagebox()
        },
        {
            {
                font = "Tahoma Bold 13",
                text = text,
                align  = 'center',
                valign = 'center',
                widget = wibox.widget.textbox,
            },
            fg = '#ffffff',
            widget = wibox.container.background,
        },
        layout = wibox.layout.fixed.vertical,
    }

    button:connect_signal("button::release", function ()
        print('Here')
        onclick()
    end)

    return button
end

function alertbox.create(s)
    local alertbar = awful.wibar {
        visible = true,
        restrict_workarea = false,
        height = 300,
        x = 0,
        y = 0,
        width = 600,
        screen = s,
        ontop = true,
        below = false,
        dockable = false,
        drawable = false,
        bg = background_color,
        border_color = border_color,
        type = "normal",
        visible = true,
    }
    alertbar:struts({bottom=0,top=0,left=0,right=0})

    alertbar.x = s.geometry.x + s.geometry.width / 2 - alertbar.width / 2
    alertbar.y = s.geometry.y + s.geometry.height / 2 - alertbar.height / 2

    local cancelbtn = wibox.widget {
        {
            {
                font = "Tahoma 16",
                text = 'Cancel',
                align  = 'center',
                valign = 'center',
                widget = wibox.widget.textbox
            },
            left = 64,
            top = 8,
            right = 64,
            bottom = 8,
            widget = wibox.container.margin,
        },
        fg = '#000000',
        bg = '#e1e1e1',
        widget = wibox.container.background,
    }
    cancelbtn:connect_signal("button::press", function ()
        alertbar:remove()
    end)

    alertbar:setup {
        {
            {
                {
                    {
                        {
                            font = "Tahoma Bold 20",
                            text = 'Log Off Windows',
                            align  = 'left',
                            valign = 'center',
                            widget = wibox.widget.textbox
                        },
                        fg = '#ffffff',
                        widget = wibox.container.background,
                    },
                    left = 12,
                    top = 16,
                    right = 0,
                    bottom = 16,
                    widget = wibox.container.margin,
                },
                {

                    layout  = wibox.layout.align.horizontal,
                },
                {

                    layout  = wibox.layout.align.horizontal,
                },
                layout  = wibox.layout.align.horizontal,
            },
            bg = bar_color,
            widget = wibox.container.background,
        },
        {
            {
                {
                    layout = wibox.layout.flex.horizontal,
                },
                {
                    alertbox.createbutton('Log Out', icons.png.logout, function ()
                        awesome.quit()
                    end),
                    alertbox.createbutton('Turn Off', icons.png.poweroff, function ()
                        awful.spawn('poweroff')
                    end),
                    layout = wibox.layout.flex.horizontal,
                },
                {
                    layout = wibox.layout.flex.horizontal,
                },
                layout = wibox.layout.align.horizontal,
            },
            left = 0,
            top = 32,
            right = 0,
            bottom = 0,
            widget = wibox.container.margin,
        },
        {
            {
                {
                    layout  = wibox.layout.align.horizontal,
                },
                {

                    layout  = wibox.layout.align.horizontal,
                },
                {
                    cancelbtn,
                    left = 0,
                    top = 12,
                    right = 32,
                    bottom = 8,
                    widget = wibox.container.margin,
                },
                layout  = wibox.layout.align.horizontal,
            },
            bg = bar_color,
            widget = wibox.container.background,
        },
        layout = wibox.layout.align.vertical,
    }

    return alertbar
end

return alertbox

