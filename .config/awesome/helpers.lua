local helpers = {}

local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

-- {{{ Volume control
function helpers.change_volume(x) 
    sign = x > 0 and "+" or "-"
    cmd = volume_control .. " set Master " .. tostring(volume_change) .. "%" .. sign
    cmd = cmd .. " ; " .. volume_control .. " set Master unmute" 
    -- Run command to change volume
    awful.spawn.easy_async(cmd,
    function(stdout, stderr, reason, exit_code)
        -- Emit signal to update volume widget afterwards
        awesome.emit_signal("signals::volume_change")
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
function helpers.wrap_margin(widget, margin)
    return wibox.widget {
        { widget = widget },
        margins = margin,
        widget = wibox.container.margin }
end
-- }}}

return helpers
