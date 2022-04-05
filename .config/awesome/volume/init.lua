local wibox = require("wibox")
local awful = require("awful")
 
volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")
 
function update_volume(widget)
    local fd = io.popen(volume_control .. " sget Master")
    local status = fd:read("*all")
    fd:close()
 
    local volume = string.match(status, "(%d?%d?%d)%%")
    volume_str_len = #volume
    volume = string.format("% 3d", volume)
 
    status = string.match(status, "%[(o[^%]]*)%]")

    -- Prepend spaces in order to assure constant with
    if volume_str_len  < 1 then
        volume = " " .. volume
    end
    if volume_str_len  < 2 then
        volume = " " .. volume
    end
    -- Append percentage sign
    volume = volume .. "%"
    -- Apply strikethrough if muted

    if not string.find(status, "on", 1, true) then
        volume = "<s>" .. volume .. "</s>"
    end
    widget:set_markup(volume)
end
 
update_volume(volume_widget)
 
awesome.connect_signal("signals::volume_change", function() update_volume(volume_widget) end)

return { widget = volume_widget }
