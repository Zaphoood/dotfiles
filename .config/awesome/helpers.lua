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
    awful.util.spawn("dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
end

function helpers.spotify_next(x)
    awful.util.spawn("dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
end

function helpers.spotify_previous(x)
    awful.util.spawn("dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
end

return helpers
