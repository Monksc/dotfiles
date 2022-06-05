local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local beautiful = require("beautiful")

local theme = {}

-- themes

theme.font          = "SF Pro Bold 18"

theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

theme.wallpaper     = gfs.get_configuration_dir() .. "wallpapers/bg6.jpg"

theme.bg = "#303030"
theme.bg_widget = "#ff0000"

theme.fg_normal = "#d0d0d0"
theme.fg_focus = "#000000"

theme.useless_gap   = 20
theme.border_radius = 10
theme.client_radius = 13
theme.sidebar_radius = 40

theme.border_color = "#000000"

-- top bar

theme.bar_bg = '#303030'

-- Top Bar Items

theme.topbar_fg_normal = '#ffffff'
theme.topbar_fg_success = '#8dad88'
theme.topbar_fg_warning = '#cc5757'

theme.topbar_bg = '#ffffff5f'

-- dock

theme.dock_bg = gfs.get_configuration_dir() .. "icons/wide-dock-dark.png"

-- widget side bar

theme.widget_bg = "#ffffff0f"
theme.widget_fg = "#d5d5d5"
theme.widget_bold_fg = "#ffffff"

theme.tasklist_bg_focus = "#ff0000"

theme.taglist_fg = "#ff0000"
theme.taglist_fg_empty = "#6f6f6f"
theme.taglist_fg_occupied = "#4c4c4c"

-- notif

theme.notification_icon = gfs.get_configuration_dir() .. "icons/notifications/notif.png"

theme.icon_theme = nil

return theme
