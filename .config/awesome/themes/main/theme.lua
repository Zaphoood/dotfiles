local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme_path = os.getenv("HOME") .. "/.config/awesome/themes/main/"
local icons_path = theme_path .. "icons/"

local theme = {}

theme.font = "JetBrainsMono Nerd Font 10"

theme.useless_gap = dpi(3)
theme.border_width = 0

-- Using the catppuccin color palette:
-- https://github.com/catppuccin/catppuccin#-palette 
theme.deep_black  = "#1a1826" -- Black 1
theme.black       = "#302d41" -- Black 3
theme.white       = "#c3bac6" -- Gray 2
theme.light_white = "#d9e0ee" -- White
theme.pink        = "#f5c2e7" -- Pink
theme.red         = "#f28fad" -- Red
theme.orange      = "#f8bd96" -- Peach
theme.yellow      = "#fae3b0" -- Yellow
theme.green       = "#abe9b3" -- Green
theme.blue        = "#96cdfb" -- Blue
-- theme.blue     = "#89dceb" -- Sky
theme.purple      = "#ddb6f2" -- Mauve
theme.grey        = "#6e6c7e" -- Gray 0
-- theme.grey     = "#988ba2" -- Gray 1
-- theme.grey     = "#c3bac6" -- Gray 2

theme.bg_normal = theme.deep_black
theme.bg_focus = theme.black
theme.bg_urgent = theme.grey
theme.bg_minimize = theme.deep_black
theme.bg_systray = theme.deep_black

theme.fg_normal = theme.grey
theme.fg_focus = theme.light_white
theme.fg_urgent = theme.red
theme.fg_minimize = theme.grey

theme.border_normal = theme.black
theme.border_focus = theme.grey
theme.border_marked = theme.grey

theme.button_hover_opacity = 0.65

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(10)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
theme.taglist_disable_icon = true

-- Variables set for theming notifications:
theme.notification_font = "JetBrainsMono Nerd Font 12"
theme.notification_margin = dpi(10)
theme.notification_border_color = theme.border_normal
theme.notification_border_width = theme.border_width
theme.notification_icon_size = dpi(60)

-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path .. "submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(150)

-- Don't show symbols indicating maximized state etc. before a client's name
theme.tasklist_plain_task_name = true

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
theme.client_corner_radius = dpi(5)
theme.widget_corner_radius = dpi(5)

-- Titlebar icons
theme.titlebar_close_button_normal = theme_path .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus = theme_path .. "titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme_path .. "titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = theme_path .. "titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_path .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme_path .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme_path .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme_path .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_path .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme_path .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme_path .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = theme_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = theme_path .. "titlebar/maximized_focus_active.png"

theme.wallpaper = theme_path .. "wallpapers/omoide-no-marnie.jpg"

-- Layout icons
theme.layout_fairh = theme_path .. "layouts/fairhw.png"
theme.layout_fairv = theme_path .. "layouts/fairvw.png"
theme.layout_floating = theme_path .. "layouts/floatingw.png"
theme.layout_magnifier = theme_path .. "layouts/magnifierw.png"
theme.layout_max = theme_path .. "layouts/maxw.png"
theme.layout_fullscreen = theme_path .. "layouts/fullscreenw.png"
theme.layout_tilebottom = theme_path .. "layouts/tilebottomw.png"
theme.layout_tileleft = theme_path .. "layouts/tileleftw.png"
theme.layout_tile = theme_path .. "layouts/tilew.png"
theme.layout_tiletop = theme_path .. "layouts/tiletopw.png"
theme.layout_spiral = theme_path .. "layouts/spiralw.png"
theme.layout_dwindle = theme_path .. "layouts/dwindlew.png"
theme.layout_cornernw = theme_path .. "layouts/cornernww.png"
theme.layout_cornerne = theme_path .. "layouts/cornernew.png"
theme.layout_cornersw = theme_path .. "layouts/cornersww.png"
theme.layout_cornerse = theme_path .. "layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Power menu icon
theme.power = icons_path .. "/powerw.svg"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Papirus"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
