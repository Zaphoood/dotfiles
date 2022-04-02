-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
-- }}}

-- File explorer
file_explorer = "nautilus"

-- Keyboard layout and shortcuts
keys = require("configuration.keys")
root.keys(keys.globalkeys)

-- User interface
ui = require("configuration.ui")

return {
    keys = keys,
    ui = ui,
}

