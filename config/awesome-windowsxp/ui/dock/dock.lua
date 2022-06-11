local dpi = require('beautiful.xresources').apply_dpi
local wibox  = require('wibox')
local awful = require('awful')
local icons = require('icons')
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")

-- spotify = "spotify"
-- spotify = "pavucontrol"
spotify = "gnome-music"
chrome = "google-chrome-stable"
-- chrome = "epiphany"
mail = chrome .. " https://www.gmail.com"
file = "nautilus"
-- netflix = "epiphany https://www.netflix.com"
netflix = "silo -a netflix"
vscode = "alacritty"
-- twitch = "silo -a twitch"
twitch = chrome .. " 'twitch.tv/jordakye'"
application_starter = 'rofi -show drun'

awful.screen.connect_for_each_screen(function (scr)

   local dock = awful.wibar {
      position = "bottom",
      height = 100,
      width = 1024,
      screen = scr,
      visible = true,
      bg = "#00000000",
      stretch = true,
      ontop = true,
      type = "dock",
   }

   -- dock.y = scr.geometry.height - 100
   -- dock.x = 0
   -- dock.width = scr.geometry.width

   local function create_img_widget(image, apps)
      local widget = wibox.widget {
         image = image,
         widget = wibox.widget.imagebox()
      }
      widget:buttons(gears.table.join(awful.button({}, 1, function()
         awful.spawn(apps)
     end)))
      return widget
   end

   local application_starter = create_img_widget(icons.png.start, application_starter)
   local spotify = create_img_widget(icons.png.spotify, spotify)
   local chrome = create_img_widget(icons.png.chrome, chrome)
   local mail = create_img_widget(icons.png.mail, mail)
   local file = create_img_widget(icons.png.file, file)
   local netflix = create_img_widget(icons.png.netflix, netflix)
   local twitch = create_img_widget(icons.png.twitch, twitch)
   local vscode = create_img_widget(icons.png.vscode, vscode)

   helpers.add_hover_cursor(spotify, "hand1")
   helpers.add_hover_cursor(chrome, "hand1")
   helpers.add_hover_cursor(mail, "hand1")
   helpers.add_hover_cursor(file, "hand1")
   helpers.add_hover_cursor(netflix, "hand1")
   helpers.add_hover_cursor(twitch, "hand1")
   helpers.add_hover_cursor(vscode, "hand1")

   local bar = wibox.widget {
      image = icons.png.dock,
      forced_width = scr.geometry.width,
      horizontal_fit_policy = "fit",
      vertical_fit_policy = "fit",
      widget = wibox.widget.imagebox()
   }

   local rightbar = wibox.widget {
      image = icons.png.rightdock,
      forced_width = 300,
      horizontal_fit_policy = "fit",
      vertical_fit_policy = "fit",
      widget = wibox.widget.imagebox()
   }

   dock : setup {
       {
                 layout = wibox.layout.align.horizontal,
                 expand = "none",
                 {
                     bar,
                     layout = wibox.layout.fixed.horizontal,
                 },
      },
      {
                 layout = wibox.layout.align.horizontal,
                 expand = "none",
                 { -- Left 
                     wibox.layout.margin(application_starter, 0, 0, 0, 0), 
                     wibox.layout.margin(spotify, -100, 0, 0, 0),
                     wibox.layout.margin(chrome, 0, 0, 0, 0), 
                     wibox.layout.margin(mail, 0, 0, 0, 0), 
                     wibox.layout.margin(file, 0, 0, 0, 0), 
                     wibox.layout.margin(netflix, 0, 0, 0, 0), 
                     wibox.layout.margin(twitch, 0, 0, 0, 0), 
                     wibox.layout.margin(vscode, 0, 0, 0, 0),
                     spacing = dpi(0),
                     layout = wibox.layout.fixed.horizontal,
                 },
                {
                   layout = wibox.layout.fixed.horizontal,
                },
                {
                    {
                        rightbar,
                        layout = wibox.layout.fixed.horizontal,
                    },
                    {
                        wibox.layout.margin(
                            wibox.widget {
                                font = "Sans Bold 18",
                                widget = wibox.widget.textclock()
                            },
                            70, 20, 0, 0
                        ),
                       align = "right",
                       layout = wibox.layout.fixed.horizontal,
                    },
                    align = "right",
                    layout  = wibox.layout.stack,
                }
      },
      layout  = wibox.layout.stack,
      widget = wibox.container.background
 }


end)



