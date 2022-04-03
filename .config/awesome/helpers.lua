local helpers = {}

local awful = require("awful")

function helpers.change_volume(x) 
    sign = x > 0 and "+" or "-"
    awful.util.spawn(volume_control .. " set Master " .. tostring(volume_change) .. "%" .. sign)
    awful.util.spawn(volume_control .. " set Master unmute")
end

function helpers.toggle_mute(x) 
     awful.util.spawn(volume_control .. " set Master toggle")
end

function helpers.spotify_play_pause(x)
    awful.util.spawn(spotify_control .. "PlayPause")
end

function helpers.spotify_next(x)
    awful.util.spawn(spotify_control .. "Next")
end

function helpers.spotify_previous(x)
    awful.util.spawn(spotify_control .. "Previous")
end

return helpers
