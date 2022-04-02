-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- {{{ Panic
-- Set up a key combination that executes a script which restarts awesome
-- with a guaranteed working configuration. This is useful when things go really wrong.
local panic_mode_key = gears.table.join(
-- globalkeys = gears.table.join(
  awful.key({ "Mod4" , "Mod1" }, "p",
      function ()
          awful.util.spawn("/home/mathis/.config/awesome/restore-rc.sh")
      end
  )
)
-- Note that the above key combination will removed by a later root.keys() call
root.keys(panic_mode_key)
-- }}}


-- Notification library
local naughty = require("naughty")

-- My stuff --
-- Configuration
require("configuration")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

