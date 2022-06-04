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
mail = "epiphany https://www.gmail.com"
file = "nautilus"
-- netflix = "epiphany https://www.netflix.com"
netflix = "silo -a netflix"
vscode = "alacritty"
-- twitch = "silo -a twitch"
twitch = "google-chrome-stable 'twitch.tv/jordakye'"

awful.screen.connect_for_each_screen(function (scr)

   local dock = awful.wibar{
      position = "bottom",
      height = 125,
      width = 1024,
      screen = scr,
      visible = true,
      bg = "#00000000",
      bgimage = beautiful.dock_bg,
   }

   dock.y = scr.geometry.height - 125

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

   dock : setup {
      {
                 layout = wibox.layout.align.horizontal,
                 expand = "none",
                 { -- Left 
                     layout = wibox.layout.fixed.horizontal,
                 },
                 {
                     wibox.layout.margin(spotify, 0, 0, 0, 40), 
                     wibox.layout.margin(chrome, 0, 0, 0, 40), 
                     wibox.layout.margin(mail, 0, 0, 0, 40), 
                     wibox.layout.margin(file, 0, 0, 0, 40), 
                     wibox.layout.margin(netflix, 0, 0, 0, 40), 
                     wibox.layout.margin(twitch, 0, 0, 0, 40), 
                     wibox.layout.margin(vscode, 0, 0, 0, 40),
                     spacing = dpi(40),
                     layout = wibox.layout.fixed.horizontal,
                 },
                 { -- Right 
                     layout = wibox.layout.fixed.horizontal,
                 },
             },
             widget = wibox.container.background
 }

end)



