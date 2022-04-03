local ui = {}

local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Theme
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/mathis/.config/awesome/themes/main/theme.lua")
-- }}}

-- {{{ Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
default_layout = 4
-- }}}

require("ui.client")
require("ui.bar")

return ui

