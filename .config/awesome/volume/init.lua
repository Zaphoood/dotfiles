local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
 
volume_widget = wibox.widget {
    {
        markup = "  0%",
        align = "right",
        widget = wibox.widget.textbox,
    },
    fg = beautiful.fg_focus,
    widget = wibox.widget.background,
}
 
function update_volume(widget)
    awful.spawn.easy_async(volume_control .. " sget Master",
    function (out)
        local volume = string.match(out, "(%d?%d?%d)%%")
        local status = string.match(out, "%[(o[^%]]*)%]")
        -- Check if getting volume has failed. 
        if not volume then return end

        volume_str_len = #volume
        volume = string.format("% 3d", volume)

        -- Prepend spaces in order to assure constant with
        -- Of course, this only works with a monospace font
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

        widget:get_children()[1]:set_markup(volume)
    end)
end
 
awesome.connect_signal("signals::volume_change", function() update_volume(volume_widget) end)

return {
    widget = volume_widget,
    update = update_volume
}
