-- tb.lua
-- Regular Titlebars
local awful = require("awful")
local gears = require("gears")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- local bling = require("modules.bling")
-- local icons = require("icons")
local helpers = require("helpers")

local function create_title_button(c, icon, shp)
    local tb = wibox.widget {
        forced_width = 30,
        forced_height = 30,
        bg = '#ff0000' .. 80,
        border_width = 1,
        border_color = "#ffffffce",
        shape = shp,
        bgimage = icon,
        widget = wibox.container.background
    }

    local function update()
        if client.focus == c then
            -- tb.bg = color_focus
        else
            -- tb.bg = color_unfocus
        end
    end
    update()

    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    -- tb:connect_signal("mouse::enter", function() tb.bg = color_focus .. 55 end)
    -- tb:connect_signal("mouse::leave", function() tb.bg = color_focus end)

    tb.visible = true
    return tb
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar

    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        if c.maximized == true then c.maximized = false end
        awful.mouse.client.move(c)

        helpers.double_click_event_handler(function()
            c.floating = false
            c.maximized = not c.maximized
        end)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))
    local borderbuttons = gears.table.join(
                              awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end), awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end))

    --  Next/Prev

    function prev_task()
        local s = awful.screen.focused()
        s.tasks[math.max(1, s.selected_tasks[1].index - 1)]:view_only()
      end

      function next_task()
        local s = awful.screen.focused()
        s.tasks[math.min(#s.tasks, s.selected_tasks[1].index + 1)]:view_only()
      end

    -- Shapes

        local ci = function(width, height)
            return function(cr) gears.shape.circle(cr, width, height) end
        end

        local bo = function(width, height, radius)
            return function(cr) gears.shape.rounded_rect(cr, width, height, radius) end
        end

        local pl = function(width, height)
            return function(cr) gears.shape.powerline(cr, width, height) end
        end

    -- Buttons

        local close = create_title_button(c, beautiful.titlebar_close_button_normal, bo(30, 30, 8))
        close:connect_signal("button::press", function() c:kill() end)

        local minimize = create_title_button(c, beautiful.titlebar_minimize_button_normal, bo(30, 30, 8))
        minimize:connect_signal("button::press", function()
            c.minimized = true
        end)

        local max = create_title_button(c, beautiful.titlebar_maximized_button_normal, bo(30, 30, 8))
        max:connect_signal("button::press", function() c.fullscreen = not c.fullscreen end)

    -- Titlebar

    awful.titlebar(c, {
        position = "top",
        size = 60,
        bg = beautiful.border_color,
    }):setup{
        {
            {
                {
                    align  = "left",
                    awful.titlebar.widget.iconwidget(c),
                    wibox.layout.margin(awful.titlebar.widget.titlewidget(c), 20, 0, 10, 0),
                    buttons = buttons,
                    layout = wibox.layout.fixed.horizontal,
                },
                {
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c),
                    buttons = buttons,
                },
                { -- Middle
                    align  = "right",
                    wibox.layout.margin(minimize, 10, 0, 15, 0),
                    wibox.layout.margin(max, 10, 0, 15, 0),
                    wibox.layout.margin(close, 10, 15, 15, 0),
                    buttons = buttons,
                    layout = wibox.layout.fixed.horizontal,
                },
                bg = beautiful.bg,
                shape = helpers.prrect(beautiful.border_radius, true, true,
                                       false, false),
                widget = wibox.container.background,
                layout = wibox.layout.align.horizontal
            },
            top = 3,
            bottom = 2,
            left = 2,
            right = 2,
            widget = wibox.container.margin
        },
        bg = beautiful.border_color,
        shape = helpers.prrect(beautiful.client_radius, true, true, false, false),
        widget = wibox.container.background
    }

    awful.titlebar(c, {
        position = "bottom",
        size = 2,
        bg = beautiful.border_color,
    }):setup{
        {
            {
                bg = beautiful.bg,
                shape = helpers.prrect(0, false, false,
                                       true, true),
                widget = wibox.container.background
            },
            top = 2,
            bottom = 2,
            left = 2,
            right = 2,
            widget = wibox.container.margin
        },
        bg = beautiful.border_color,
        shape = helpers.prrect(0, false, false, true, true),
        widget = wibox.container.background
    }

    awful.titlebar(c, {
        position = "left",
        size = 2,
        bg = beautiful.border_color
    })

    awful.titlebar(c, {
        position = "right",
        size = 2,
        bg = beautiful.border_color
    })

end)
