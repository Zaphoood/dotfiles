local configuration = {}
-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
-- }}}

-- Command for setting volume
volume_control = "amixer -D pulse"
-- Amount in percent by which the audio volume is changed
-- when a volume +/- key is pressed
volume_change = 5
-- Command used to control Spotify playback
-- Must be concatenated with either `Play`, `Pause`, `PlayPause`, `Next` or `Previous`
spotify_control = "dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player."

-- File explorer
file_explorer = "nautilus"

-- Keyboard layout and shortcuts
configuration.keys = require("configuration.keys")
root.keys(configuration.keys.globalkeys)

return configuration

