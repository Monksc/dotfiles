local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local icons = require('icons')
local beautiful = require("beautiful")
local helpers = require("helpers")
local menubar = require("menubar")
local alertbox = require("ui.alertbox.alertbox")

require("awful.autofocus")

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

menubar.menu_gen.generate(function(entries)
awful.screen.connect_for_each_screen(function(s)

    local function create_textfield_withicon(icon, text, align, func)
        local normalfg = '#484848'

        local textfield = wibox.widget {
            wibox.widget {
                {
                    {
                        image = icon,
                        forced_height = 40,
                        forced_width = 40,
                        widget = wibox.widget.imagebox(),
                    },
                    {
                        font = "Tahoma Bold 13",
                        text = text,
                        align  = align,
                        valign = 'center',
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.flex.horizontal,
                },
                left = 8,
                top = 8,
                right = 8,
                bottom = 8,
                widget = wibox.container.margin,
                buttons = {
                    awful.button({ }, 1, func),
                },
            },
            fg = normalfg,
            widget = wibox.container.background,
        }
        textfield:connect_signal("mouse::enter", function ()
            textfield.fg = '#cecece'
            textfield.bg = '#0000ff'
        end)
        textfield:connect_signal("mouse::leave", function ()
            textfield.fg = normalfg
            textfield.bg = '#00000000'
        end)

        return textfield
    end

    local function create_listview_of_applications(category)
        local menu = awful.wibar {
            visible = true,
            height = 1250,
            y = 0,
            width = 300,
            screen = s,
            ontop = true,
            below = false,
            dockable = true,
            drawable = true,
            bg = "#ffffffff",
            type = "background",
            visible = true,
        }

        local speed = 40

        menu.buttons = awful.util.table.join(
            awful.button({ }, 4, function (c)
                if menu.widget.children[1].top > -speed then
                    menu.widget.children[1].top = 0
                else
                    menu.widget.children[1].top = menu.widget.children[1].top + speed
                end
            end),
            awful.button({ }, 5, function (c)
                menu.widget.children[1].top = menu.widget.children[1].top - speed
            end)
        )

        menu.x = 300
        menu.y = s.geometry.height - menu.height - 100
        menu:struts({bottom=0,top=0,left=0,right=0})
        menu:connect_signal("mouse::leave", function ()
            menu.visible = false
        end)

        local categoriesListView = wibox.widget {
            layout = wibox.layout.fixed.vertical,
        }
        for k in pairs(entries) do
            if (entries[k].icon ~= nil) and (entries[k].category ~= nil)
                and (entries[k].category == category) then
                categoriesListView:add(
                    create_textfield_withicon(entries[k].icon, entries[k].name, 'left', function ()
                        awful.spawn(entries[k].cmdline)
                    end)
                )
            end
        end

        menu : setup {
            {
                categoriesListView,
                left = 0,
                top = 0,
                right = 0,
                bottom = 0,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.vertical,
        }

        return menu
    end


    -- Create Sub Menu --

    local categorymenu = awful.wibar {
        visible = true,
        height = 600,
        x = 100,
        y = 0,
        width = 300,
        screen = s,
        ontop = true,
        below = true,
        dockable = true,
        drawable = true,
        bg = "#ffffffff",
        type = "background",
        visible = false,
    }
    categorymenu.x = 100
    categorymenu.y = s.geometry.height - categorymenu.height - 100
    categorymenu:struts({bottom=0,top=0,left=0,right=0})
    categorymenu:connect_signal("mouse::leave", function ()
        categorymenu.visible = false
    end)

    local categoriesSeen = {}
    local categoriesListView = wibox.widget {
        layout = wibox.layout.fixed.vertical,
    }
    for k in pairs(entries) do
        if (entries[k].icon ~= nil) and (entries[k].category ~= nil) and (not (categoriesSeen[entries[k].category] ~= nil)) then
            print(helpers.dump(entries[k]))
            categoriesListView:add(
                create_textfield_withicon(entries[k].icon, entries[k].category, 'left', function ()
                    categorymenu.submenu = create_listview_of_applications(entries[k].category)
                end)
            )
            categoriesSeen[entries[k].category] = true
        end
    end

    categorymenu : setup {
        categoriesListView,
        layout = wibox.layout.fixed.vertical,
    }


    -- Create Menu --

    local menubar = awful.wibar({
        visible = true,
        height = 660,
        x = 0,
        y = 0,
        width = 600,
        screen = s,
        ontop = true,
        below = true,
        dockable = true,
        drawable = true,
        bg = "#0000ffff",
        type = "background",
        visible = false,
    })
    menubar.categorymenu = categorymenu
    menubar.x = 0
    menubar.y = s.geometry.height - menubar.height - 61
    menubar:struts({bottom=0,top=0,left=0,right=0})



    local function create_textfield(text, align, func)
        local normalfg = '#484848'

        local textfield = wibox.widget {
            wibox.widget{
                {
                    font = "Tahoma Bold 13",
                    text = text,
                    align  = align,
                    valign = 'center',
                    widget = wibox.widget.textbox
                },
                left = 8,
                top = 8,
                right = 8,
                bottom = 8,
                widget = wibox.container.margin,
                buttons = {
                    awful.button({ }, 1, func),
                },
            },
            fg = normalfg,
            widget = wibox.container.background,
        }
        textfield:connect_signal("mouse::enter", function ()
            textfield.fg = '#cecece'
            textfield.bg = '#0000ff'
        end)
        textfield:connect_signal("mouse::leave", function ()
            textfield.fg = normalfg
            textfield.bg = '#00000000'
        end)

        return textfield
    end

    local function create_divider()
        return wibox.widget {
            orientation = 'horizontal',
            thickness = 10,
            span_ratio = 1.0,
            border_width = 10,
            forced_height = 5,
            color = '#cecece',
            widget = wibox.widget.separator
        }
    end

    local function create_buttonbar(icon, text, onclick)
        local buttons = wibox.widget {
            {
                {
                    {
                        image = icon,
                        forced_height = 50,
                        forced_width = 50,
                        widget = wibox.widget.imagebox(),
                    },
                    {
                        {
                            font = "Tahoma Bold 13",
                            text = text,
                            align  = 'left',
                            valign = 'center',
                            widget = wibox.widget.textbox
                        },
                        bg = "#ffffff00",
                        fg = "#ffffff",
                        widget = wibox.container.background,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 8,
                top = 8,
                right = 8,
                bottom = 8,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.horizontal,
        }

        buttons:buttons(
            awful.util.table.join(
              awful.button(
               {}, 1, function()
                   onclick()
               end
              )
            )
        )

        return buttons
    end

    local programsListView = wibox.widget {
        layout  = wibox.layout.fixed.vertical,
    }
    local count = 0
    for k in pairs(entries) do
        if count == 2 then
            programsListView:add(create_divider())
        end
        if count > 6 then
            break
        end
        if entries[k].category == 'games' then
            programsListView:add(
                create_textfield_withicon(entries[k].icon, entries[k].name, 'left', function ()
                    awful.spawn(entries[k].cmdline)
                    print(helpers.dump(entries[k]))
                end)
            )
            count = count + 1
        end
    end

    local header = {
        {
            {
                {
                    wibox.widget {
                        image = icons.png.me,
                        forced_height = 100,
                        forced_width = 100,
                        widget = wibox.widget.imagebox(),
                    },
                    wibox.widget {
                        font = "Tahoma Bold 18",
                        color = '#000000',
                        text = 'Cameron',
                        align  = 'center',
                        valign = 'center',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                layout = wibox.layout.flex.horizontal,
            },
            left = 8,
            top = 8,
            right = 8,
            bottom = 8,
            widget = wibox.container.margin,
        },
        forced_width = menubar.width,
        bg = "#0000ff",
        widget = wibox.container.background,
    }

    local bottombar = {
        {
            {
                layout = wibox.layout.fixed.horizontal,
            },
            {
                layout = wibox.layout.flex.horizontal
            },
            {
                {
                    create_buttonbar(icons.png.logout, 'Log out', function()
                        alertbox.create(s)
                        -- awesome.quit()
                    end),
                    create_buttonbar(icons.png.poweroff, 'Turn off computer', function()
                        alertbox.create(s)
                        -- awful.spawn('poweroff')
                    end),
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 8,
                top = 8,
                right = 8,
                bottom = 8,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.align.horizontal,
        },
        forced_width = menubar.width,
        bg = "#0000ff",
        widget = wibox.container.background,
    }

    menubar : setup {
        header,
        {
            {
                {
                    programsListView,
                    create_divider(),
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                        },
                        {
                            create_textfield('All Programs', 'center', function()
                                categorymenu.visible = true
                            end),
                            wibox.widget {
                                image = icons.png.arrow,
                                forced_height = 50,
                                forced_width = 50,
                                widget = wibox.widget.imagebox(),
                            },
                            layout = wibox.layout.fixed.horizontal,
                        },
                        {
                            layout = wibox.layout.fixed.horizontal,
                        },
                        layout = wibox.layout.align.horizontal,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                bg = "#ffffff",
                widget = wibox.container.background,
            },
            {
                programsListView,
                bg = "#cadbee",
                widget = wibox.container.background,
            },
            layout = wibox.layout.flex.horizontal,
        },
        bottombar,
        layout = wibox.layout.fixed.vertical,
    }

    s.startmenu = menubar
end)
end)

