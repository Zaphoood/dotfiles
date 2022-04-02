#!/usr/bin/env bash

# Restore a working awesome environment when something goes wrong.
# Renames the rc in the config folder and restarts the awesome client.
# This way, awesome will fall back to `/etc/xdg/awesome/rc.lua`, which is the
# default configuration.

mv $HOME/.config/awesome/rc.lua $HOME/.config/awesome/rc.lua.bad
echo 'awesome.restart()' | awesome-client
