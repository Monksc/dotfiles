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
                spacing = 5,
                forced_num_rows = 2,
                layout = wibox.layout.grid.horizontal
            },
            widget_template = {
                {
                    {
                        id     = 'clienticon',
                        widget = awful.widget.clienticon,
                    },
                    margins = 4,
                    widget  = wibox.container.margin,
                },
                id              = 'background_role',
                forced_width    = 48,
                forced_height   = 48,
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

