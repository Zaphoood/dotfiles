-- Standard awesome library
local awful = require("awful")
local gears = require("gears")
local gfs = gears.filesystem
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
-- }}}

-- File explorer
file_explorer = "nautilus"
return {
    keys = require("configuration.keys"),
    ui = require("configuration.ui")
}

