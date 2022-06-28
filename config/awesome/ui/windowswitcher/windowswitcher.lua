local wibox = require('wibox')
local dpi = require("beautiful.xresources").apply_dpi
local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local icons = require('icons')
local helpers = require("helpers")


local windowswitcher = {}

awful.screen.connect_for_each_screen(function(s)
    s.tabpopup = awful.popup {
        widget = awful.widget.tasklist {
            screen   = s,
            filter   = awful.widget.tasklist.filter.allscreen,
            buttons  = tasklist_buttons,
            style    = {
                shape = gears.shape.rounded_rect,
            },
            layout   = {
                spacing = 4,
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = {
                {
                    {
                        {
                            {
                                id     = 'clienticon',
                                widget = awful.widget.clienticon,
                                valign = 'center',
                            },
                            top = 16,
                            right = 4,
                            down = 16,
                            left = 4,
                            forced_width = 128,
                            forced_height = 128,
                            widget  = wibox.container.margin,
                        },
                        valign = 'center',
                        halign = 'center',
                        widget = wibox.container.place,
                    },
                    {
                        {
                            id     = 'text_role',
                            align  = 'center',
                            valign = 'center',
                            widget = wibox.widget.textbox,
                        },
                        valign = 'center',
                        halign = 'center',
                        widget = wibox.container.place,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                id              = 'background_role',
                forced_width    = 256,
                forced_height   = 194,
                widget          = wibox.container.background,
                create_callback = function(self, c, index, objects) --luacheck: no unused
                    self:get_children_by_id('clienticon')[1].client = c
                end,
            },
        },
        border_color = '#777777',
        border_width = 2,
        ontop        = true,
        placement    = awful.placement.centered,
        visible      = false,
        shape        = gears.shape.rounded_rect
    }
end)

function windowswitcher.show()
    screen[1].tabpopup.visible = true
end

function windowswitcher.close()
    screen[1].tabpopup.visible = false
end

return windowswitcher

