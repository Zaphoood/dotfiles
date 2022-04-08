local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")

local power = {}

local menu_items = {
    { name = "Lock",      icon = beautiful.icons.lock, callback = helpers.lock },
    { name = "Sleep",     icon = beautiful.icons.sleep, callback = helpers.sleep },
    { name = "Log out",   icon = beautiful.icons.log_out, callback = helpers.logout },
    { name = "Power off", icon = beautiful.icons.power, callback = helpers.shutdown },
}

power.widget = wibox.widget {
    {
        image = beautiful.icons.power,
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
    border_width = dpi(1),
    border_color = beautiful.bg_focus,
    maximum_width = dpi(400),
    offset = {
        x = dpi(-2),
        y = dpi(5)
    },
    widget = {}
}

local rows = { layout = wibox.layout.fixed.vertical }
for _, item in ipairs(menu_items) do
    local row = wibox.widget {
        {
            {
                {
                    {
                        image = item.icon,
                        forced_width = dpi(16),
                        forced_height = dpi(16),
                        widget = wibox.widget.imagebox,
                    },
                    left = dpi(5),
                    right = dpi(5),
                    widget = wibox.container.margin,
                },
                {
                    text = item.name,
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal
            },
            right = dpi(5),
            top = dpi(3),
            bottom = dpi(3),
            widget = wibox.container.margin,
        },
        fg = beautiful.white, -- Sets the text color of the contained textbox
        widget = wibox.container.background
    }
    -- Change background when hovering
    row:connect_signal("mouse::enter", function(c)
        c:set_bg(beautiful.bg_focus)
        c:set_fg(beautiful.light_white)
    end)
    row:connect_signal("mouse::leave", function(c)
        c:set_bg(beautiful.bg_normal)
        c:set_fg(beautiful.white)
    end)

    -- Execute callback when clicked
    row:buttons(gears.table.join(awful.button({}, 1, function()
        -- First, hide pop-up
        popup.visible = false
        -- Then, run callback function
        item.callback(row)
    end)))
    table.insert(rows, row)
end
popup:setup(rows)

power.widget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            if popup.visible then
                popup.visible = not popup.visible
            else
                 popup:move_next_to(mouse.current_widget_geometry)
            end
    end))
)

-- TODO: With the following block uncommented, the pop-up would be unusable.
-- Find a way to hide the pop-up if the mouse has left if for a certain amount
-- of time.
--[[
power.widget:connect_signal("mouse::leave",
    function() popup.visible = false end)
--]]

return power
