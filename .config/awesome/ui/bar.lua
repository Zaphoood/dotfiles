local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Keyboard layout
local keys = require("configuration.keys")

-- Volume control
local volume = require("volume")
volume.update(volume.widget)

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- local xresources = require("beautiful.xresources")
-- local dpi = xresources.apply_dpi

-- Menubar
-- What does menubar even do??
-- local menubar = require("menubar")
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- {{{ Menu
local menu_terminal = { "Terminal", terminal }
local menu_debian = { "Debian", debian.menu.Debian_menu.Debian }

-- TODO: Make this look better
if has_fdo then
    mymainmenu = freedesktop.menu.build({
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
            menu_debian,
            menu_terminal,
        }
    })
end


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- }}}


-- {{{ Wibar
-- Create a textclock widget
textclock_inner = wibox.widget.textclock()
-- Wrap it inside a background widget since I haven't figured
-- out any other way to set the foreground color
textclock = wibox.widget {
    { widget = textclock_inner },
    fg = beautiful.fg_focus,
    widget = wibox.widget.background,
}

-- Create a wibox for each screen and add it
local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end)
)


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

tags = { "code", "fun", "work", "other" }

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(tags, s, awful.layout.layouts[default_layout])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox_inner = awful.widget.layoutbox(s)
    -- Wrap it inside a margin
    s.layoutbox = wibox.widget { 
        { widget = s.layoutbox_inner:get_children()[1] },
        margins = dpi(2),
        widget = wibox.container.margin
    }
    s.layoutbox:buttons(gears.table.join(
        -- Click to change layout
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        -- Scroll to change layout
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape = gears.shape.rounded_bar,
        },
        widget_template = {
                {
                    {
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox,
                        },
                        left = dpi(10),
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                id = "background_role",
                widget = wibox.container.background,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            -- mykeyboardlayout,
            -- Use kdbcfg's widget instead
            keys.kbdcfg.widget,
            -- Volume control widget
            volume.widget,
            -- wibox.widget.systray(),
            textclock,
            s.layoutbox,
            layout = wibox.layout.fixed.horizontal,
        },
    }
end)
-- }}}
