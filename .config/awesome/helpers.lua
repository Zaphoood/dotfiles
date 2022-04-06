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

return helpers
