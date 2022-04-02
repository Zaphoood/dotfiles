#!/usr/bin/env bash

# Re-enable a config that was previously disabled through `restore-rc.sh`

mv $HOME/.config/awesome/rc.lua.bad $HOME/.config/awesome/rc.lua
echo 'awesome.restart()' | awesome-client
