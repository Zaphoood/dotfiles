local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
 
volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")
 
function update_volume(widget)
    -- The `-D pulse` flag is necessary when using pulseaudio
    local fd = io.popen("amixer -D pulse sget Master")
    local status = fd:read("*all")
    fd:close()
 
    local volume = string.match(status, "(%d?%d?%d)%%")
    volume = string.format("% 3d", volume)
 
    status = string.match(status, "%[(o[^%]]*)%]")

    -- Append percentage sign
    volume = volume .. "%"
    -- Apply strikethrough if muted
    if not string.find(status, "on", 1, true) then
        volume = "<s>" .. volume .. "</s>"
    end
    widget:set_markup(volume)
end
 
update_volume(volume_widget)
 
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
mytimer:start()
