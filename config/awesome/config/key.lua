local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local revelation = require("revelation")

local keys = {}

require("awful.hotkeys_popup.keys")
require("awful.autofocus")
require("awful.remote")
require("screenful")

revelation.init()

modkey = "Mod4"
modaltkey = "Mod1"

terminal = "alacritty"
browser = "epiphany"
-- fm = "thunar"
fm = "nautilus"
vscode = terminal
-- application_launcher = "findex"
application_launcher = "rofi -show drun"
application_launcher2 = "rofi -show window"
-- application_launcher2 = "findex"
discord = "discord"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
  end)
)


mykeyboardlayout = awful.widget.keyboardlayout()

keys.desktopbuttons = gears.table.join(
    awful.button({ }, 2, function() sidebar_toggle()
    end)
)

globalkeys = gears.table.join(
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("/home/cammonks/Projects/dotfiles/.bin/changebrightness.sh '-2000'") end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("/home/cammonks/Projects/dotfiles/.bin/changebrightness.sh '2000'") end),
    awful.key({ "Shift" }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("/home/cammonks/Projects/dotfiles/.bin/changebrightness.sh '-500'") end),
    awful.key({ "Shift" }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("/home/cammonks/Projects/dotfiles/.bin/changebrightness.sh '500'") end),


    awful.key({ modkey,              }, "space", function () awful.spawn.easy_async_with_shell(application_launcher)   end,
              {description = "open an application launcher", group = "launcher"}),
    awful.key({ modkey, "Shift"      }, "space", function () awful.spawn.easy_async_with_shell("ulauncher")   end,
              {description = "open an application launcher", group = "launcher"}),
    awful.key({ modaltkey,           }, "space", function () awful.spawn.easy_async_with_shell(application_launcher2)   end,
              {description = "open an application launcher", group = "launcher"}),
    awful.key({ modkey, "Control", "Shift"}, "l", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,  "Ctrl", }, "1", function () awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/centermouse.sh eDP-1")   end,
              {description = "Move mouse to monitor.", group = "client"}),
    awful.key({ modkey,  "Ctrl", }, "2", function () awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/centermouse.sh DP-1")   end,
              {description = "Move mouse to monitor.", group = "client"}),
    awful.key({ modkey,  "Ctrl", }, "3", function () awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/centermouse.sh DP-2")   end,
              {description = "Move mouse to monitor.", group = "client"}),
    -- awful.key({ modkey,  "Ctrl", "Shift", }, "1", function () awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/centermouse.sh eDP-1")   end,
    --           {description = "Move mouse to monitor.", group = "client"}),
    -- awful.key({ modkey,  "Ctrl", "Shift", }, "2", function () awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/centermouse.sh DP-1")   end,
    --           {description = "Move mouse to monitor.", group = "client"}),
    -- awful.key({ modkey,  "Ctrl", "Shift", }, "3", function () awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/centermouse.sh DP-2")   end,
    --           {description = "Move mouse to monitor.", group = "client"}),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modaltkey, "Control"}, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modaltkey, "Control"}, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey,              }, "s", function () awful.spawn("systemsettings5 kcm_bluetooth")   end,
              {description = "Settings", group = "client"}),
    awful.key({ modkey,              }, "a", function () awful.spawn("pavucontrol")   end,
              {description = "Audio settings", group = "client"}),
    awful.key({ modkey,              }, "p", function () awful.spawn("gnome-control-center power")   end,
              {description = "Power settings", group = "client"}),
    awful.key({ modkey,              }, "c", function () awful.spawn.easy_async_with_shell("rofi -show calc -modi calc -no-show-match -no-sort")   end,
              {description = "Power settings", group = "client"}),
    awful.key({ "Ctrl",           }, "F9",      revelation),
    awful.key({ modaltkey, "Shift"}, "space",   revelation),

    -- Special Key Bindings Start
    -- awful.key({ modaltkey,           }, "c", function ()
    --     awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/sendkeystrokes.sh copy")   end),
    -- awful.key({ modaltkey,           }, "v", function ()
    --     awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/sendkeystrokes.sh paste")   end),
    -- awful.key({ modaltkey,           }, "w", function ()
    --     awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/sendkeystrokes.sh deletetab")   end),
    -- awful.key({ "Control",           }, "w", function ()
    --     awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/sendkeystrokes.sh deletebackwords")   end),
    -- awful.key({ "Control",           }, "a", function ()
    --     awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/sendkeystrokes.sh startofword")   end),
    -- awful.key({ "Control",           }, "e", function ()
    --     awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/sendkeystrokes.sh endofword")   end),
    -- Special Key Bindings End

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () awful.spawn(browser) end,
              {description = "spawn browser", group = "launcher"}),
    awful.key({ modkey, "Shift",  }, "w", function () awful.spawn("surf -z 1.5 -N duckduckgo.com") end,
              {description = "spawn browser", group = "launcher"}),
    awful.key({ modkey, "Shift",  "Control"}, "w", function () awful.spawn("firefox --private-window 'duckduckgo.com'") end,
              {description = "spawn browser", group = "launcher"}),
    awful.key({ modkey, "Control",  }, "w", function () awful.spawn("firefox") end,
              {description = "spawn browser", group = "launcher"}),

    awful.key({ modkey, "Control" }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            -- awful.client.focus.history.previous()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end),

    awful.key({ modkey, "Shift"   }, "Tab",
        function ()
            -- awful.client.focus.history.previous()
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Audio
	awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +3%",
        function() awesome.emit_signal("volume_refresh") end)
    end, { description = "raise volume by 3%", group = "audio" }),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -3%",
        function() awesome.emit_signal("volume_refresh") end)
    end, {description = "lower volume by 3%", group = "audio"}),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn.easy_async_with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle",
        function() awesome.emit_signal("volume_refresh") end)
    end, {description = "mute audio", group = "audio"}),

    awful.key({"Shift"}, "XF86AudioRaiseVolume", function()
        awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/applicationvolume.bs '+1%'",
        function() awesome.emit_signal("volume_refresh") end)
    end, { description = "raise volume by 3%", group = "audio" }),
    awful.key({"Shift"}, "XF86AudioLowerVolume", function()
        awful.spawn.easy_async_with_shell("/home/cammonks/Projects/dotfiles/.bin/applicationvolume.bs '-1%'",
        function() awesome.emit_signal("volume_refresh") end)
    end, {description = "lower volume by 3%", group = "audio"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ }, "Print", function () awful.spawn.easy_async_with_shell("scrot -cd1 -q100 ~/Pictures/Screenshot-h%M%S.png") end, 
              {description = "take screenshot", group = "screen"}),
    awful.key({ "Control", }, "Print", function () awful.spawn.easy_async_with_shell("scrot -s '%Y-%m-%d_$wx$h_scrot.png' -e 'mv $f ~/Pictures'") end, 
              {description = "take screenshot", group = "screen"}),

    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),
    -- awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
    --           {description = "select next", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    --           {description = "select previous", group = "layout"}),
    awful.key({ modkey },            "z",     function() sidebar_toggle()                     end,
              {description = "show or hide sidebar", group = "awesome"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),
    awful.key({ modkey, "Shift" }, "n",
              function ()
                  local tag = awful.tag.selected()
                  for i=1, #tag:clients() do
                      tag:clients()[i].minimized=false
                      tag:clients()[i]:redraw()
                  end
              end,
              {description = "restore minimized", group = "client"}),
    -- Menubar
    awful.key({ modkey }, "r", function() awful.spawn.easy_async_with_shell("rofi -show drun") end,
              {description = "show the menubar", group = "launcher"}),
    -- emoji
    awful.key({ modkey }, "d", function() awful.spawn.easy_async_with_shell("rofi -show emoji -modi emoji") end,
              {description = "emoji menu", group = "launcher"})

)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

root.buttons(keys.desktopbuttons)

return keys
