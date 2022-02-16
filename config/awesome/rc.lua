pcall(require, "luarocks.loader")

                                              
-- 📚 Library

local gears = require("gears")
local gfs = require("gears.filesystem")
local awful = require("awful")
local beautiful = require("beautiful")

-- 🎨 Theme

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

-- ✨ Modules

local bling = require("modules.bling")

-- Require

require("awful.autofocus")
require("awful.hotkeys_popup.keys")
require("config")
require("ui")
require("notifs")

                                              

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.closebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            jwful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)



-- 🚀 Launch Script

local autostart = require("autostart")


-- Signals And Rules

awesome.register_xproperty("WM_NAME", "string")

awful.rules.rules = {
  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = awful.client.focus.filter,
                   raise = true,
                   keys = clientkeys,
                   buttons = clientbuttons,
                   screen = awful.screen.preferred,
                   placement = awful.placement.no_overlap+awful.placement.no_offscreen
   }
  },
  { rule_any = {
    }, properties = { floating = true }},

  { rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
  },
}

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
                   title = "Error occured",
                   text = awesome.startup_errors })
end

client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and not c.size_hints.user_position and
      not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end

end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus",
                    function(c) c.border_color = beautiful.border_focus end)

client.connect_signal("unfocus",
                    function(c) c.border_color = beautiful.border_normal end)

-- My Custom
modkey = "Mod4"
modaltkey = "Mod1"
terminal = "alacritty"
browser = "epiphany"
application_launcher = "findex"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

root.keys(globalkeys)

require("signals")

if true then
    -- awful.util.spawn(terminal)
    -- local screen = awful.screen.focused()
    -- local tag = screen.tags[2]
    -- if tag then
    --    tag:view_only()
    -- end
    -- awful.util.spawn(browser)

    awful.util.spawn("setxkbmap -option 'caps:ctrl_modifier'")
    awful.util.spawn("xinput --set-prop --type=int 'PIXA3854:00 093A:0274 Touchpad' 'libinput Natural Scrolling Enabled Default' 1")
    awful.util.spawn("xinput --set-prop --type=int 'PIXA3854:00 093A:0274 Touchpad' 'libinput Natural Scrolling Enabled' 1")
    awful.util.spawn("xinput --set-button-map 'PIXA3854:00 093A:0274 Touchpad' 1 2 3 4 5 6 7")
    awful.util.spawn("xinput set-prop 'PIXA3854:00 093A:0274 Touchpad' 'libinput Click Method Enabled' 0 1")
    awful.util.spawn("gestures")
end


