local helpers = {}

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

-- {{{ Volume control
function helpers.change_volume(x) 
    sign = x > 0 and "+" or "-"
    cmd_change_volume = volume_control .. " set Master " .. tostring(volume_change) .. "%" .. sign
    cmd_unmute = volume_control .. " set Master unmute" 
    -- In order to run to commands consecutively, the second command is executed by the callback
    -- function of the first one. This way, we ensure that both commands have finished executing
    -- before emitting the `volume_change` signal
    -- Change volume
    awful.spawn.easy_async(
        cmd_change_volume,
        function(stdout, stderr, reason, exit_code)
            -- Unmute 
            awful.spawn.easy_async(
                cmd_unmute,
                function(stdout, stderr, reason, exit_code)
                    -- Emit signal to update volume widget afterwards
                    awesome.emit_signal("signals::volume_change")
                end)
        end)
end

function helpers.toggle_mute(x) 
    awful.spawn.easy_async(volume_control .. " set Master toggle",
    function(stdout, stderr, reason, exit_code)
        awesome.emit_signal("signals::volume_change")
    end)
end
-- }}}

-- {{{ Media
function helpers.spotify_play_pause(x)
    awful.util.spawn(spotify_control .. "PlayPause")
end

function helpers.spotify_next(x)
    awful.util.spawn(spotify_control .. "Next")
end

function helpers.spotify_previous(x)
    awful.util.spawn(spotify_control .. "Previous")
end
-- }}}

-- {{{ UI
function helpers.wrap_margin(...)
    -- Wrap any given widget inside a wibox.widget.margin
    -- First argument must be the widget, the following arguments can be either
    -- a number, which will be margin applied to all sides,
    -- four numbers, which will be the the left, right, top and bottom margins respectively,
    -- or a table containing the keys `left`, `right`, `top` and/or `bottom`.
    
    local n_args = select("#", ...)
    local widget = select(1, ...)
    margins = {
        left   = 0,
        right  = 0,
        top    = 0,
        bottom = 0,
    }
    if n_args == 2 then
        if type(select(2, ...)) == "number" then
            margins["left"]   = select(2, ...)
            margins["right"]  = select(2, ...)
            margins["top"]    = select(2, ...)
            margins["bottom"] = select(2, ...)
        elseif type(select(2, ...)) == "table" then
            margins = select(2, ...)
        end
    elseif n_args == 5 then
        margins["left"]   = select(2, ...)
        margins["right"]  = select(3, ...)
        margins["top"]    = select(4, ...)
        margins["bottom"] = select(5, ...)
    end
    return wibox.widget {
        { widget = widget },
        left   = margins["left"],
        right  = margins["right"],
        top    = margins["top"],
        bottom = margins["bottom"],
        widget = wibox.container.margin,
    }
end
-- }}}

-- {{{ OS
function helpers.shutdown()
    -- TODO: Check if programs are still running
    awful.util.spawn(shutdown_cmd)
end

function helpers.logout()
    awesome.quit()
end

function helpers.lock()
    -- `lock_screen` is a command defined in configuration/init.lua
    awful.spawn.easy_async(lock_screen)
end

function helpers.sleep()
    naughty.notify({ title = "Oopsie whoopise uwu",
        text = "Sleep is not implemented yet" })
end
-- }}}
return helpers
