local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local icons = require('icons')
local beautiful = require("beautiful")
local helpers = require("helpers")

require("awful.autofocus")

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

trash = '/usr/bin/nautilus ".local/share/Trash/files"'

awful.screen.connect_for_each_screen(function(s)
    -- Add widgets
    local backgroundwibar = awful.wibar {
      position = "left",
      visible = true,
      height = s.geometry.height,
      width = 100,
      screen = s,
      ontop = false,
      below = true,
      dockable = true,
      drawable = true,
      bg = "#ffffff00",
      type = "background",
    }

    local function create_img_widget(image, apps)
       local widget = wibox.widget {
          image = image,
          widget = wibox.widget.imagebox()
       }
       widget:buttons(gears.table.join(awful.button({}, 1, function()
          awful.spawn(apps)
      end)))

       return wibox.layout.margin(widget, 15, 15, 40, 0)
    end

    local function create_textfield(text)
        return wibox.widget{
            font = "Tahoma 12",
            text = text,
            align  = 'center',
            valign = 'center',
            widget = wibox.widget.textbox
        }
    end
    backgroundwibar:struts ({bottom=0,top=0,left=0,right=0})

    backgroundwibar : setup {
        {
            {
                {
                    { -- Left widgets
                        create_img_widget(icons.png.ie, chrome),
                        create_textfield('Internet Explorer'),
                        create_img_widget(icons.png.trash, trash),
                        create_textfield('Trash'),
                        layout = wibox.layout.fixed.vertical,
                    },
                    {
                        layout = wibox.layout.fixed.horizontal,
                    },
                    {
                        layout = wibox.layout.fixed.horizontal,
                    },
                    layout = wibox.layout.align.horizontal,
                },
                layout = wibox.layout.align.horizontal,
            },
            right = 2,
            bottom = 2,
            widget = wibox.container.margin
        },
        bg = "#ffffff00",
        widget = wibox.container.background
    }

    -- s.workarea.width = 300
end)
