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

theme.widget_music_icon = "icons/music-light.png"

theme.widget_bg = "#ffffff0f"
theme.widget_fg = "#d5d5d5"
theme.widget_bold_fg = "#ffffff"

-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_bg_focus = "#303030"
theme.tasklist_bg_urgent = "#ff0000"
theme.tasklist_fg_focus = "#ffffff"
theme.tasklist_fg_urgent = "#ffffff"

theme.taglist_fg = "#ff0000"
theme.taglist_fg_empty = "#6f6f6f"
theme.taglist_fg_occupied = "#4c4c4c"

-- notif

theme.notification_font = "SF Pro Bold 18"
theme.notification_bg   = "#303030"
theme.notification_fg   = "#ececec"
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_icon = gfs.get_configuration_dir() .. "icons/notifications/notif.png"

-- rnotification.connect_signal('request::rules', function()
--     rnotification.append_rule {
--         rule       = { urgency = 'critical' },
--         properties = { bg = '#ff0000', fg = '#ffffff' }
--     }
-- end)

theme.icon_theme = nil

return theme
