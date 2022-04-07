local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")

local menu_items = {
    { name = "Lock", icon = "", callback = function() end },
    { name = "Log out", icon = "", callback = function() end },
    { name = "Power off", icon = "", callback = function() end },
}

local widget = wibox.widget {
    {
        image = beautiful.power,
        resize = true,
        widget = wibox.widget.imagebox
    },
    left = 5,
    right = 5,
    top = 3,
    bottom = 3,
    widget = wibox.container.margin
}

local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.widget_corner_radius)
    end,
    border_width = 1,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {}
}

local rows = { layout = wibox.layout.fixed.vertical }
for _, item in ipairs(menu_items) do
    local row = wibox.widget {
        {
            {
                image = item.icon,
                forced_width = dpi(16),
                forced_height = dpi(16),
                widget = wibox.widget.imagebox,
            },
            {
                text = item.name,
                widget = wibox.widget.textbox
            },
            -- spacing = dpi(12),
            layout = wibox.layout.fixed.horizontal
        },
        right = dpi(5),
        top = dpi(3),
        bottom = dpi(3),
        widget = wibox.container.margin,
    }
    table.insert(rows, row)
end
popup:setup(rows)

widget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            if popup.visible then
                popup.visible = not popup.visible
            else
                 popup:move_next_to(mouse.current_widget_geometry)
            end
    end))
)

return { widget = widget }
