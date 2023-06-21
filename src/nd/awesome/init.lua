local fn_lib          = require 'nd.lib.core.fn'
local str_lib         = require 'nd.lib.core.str'
local tab_lib         = require 'nd.lib.core.tab'
local type_lib        = require 'nd.lib.core.type'

local cache_lib       = require 'nd.lib.cache.fs'
local event_lib       = require 'nd.lib.event'

local key_cache_res   = require 'nd.res.key.cache'
local color_cache_res = require 'nd.res.color.cache'

local key_config      = require 'nd.awesome.config.key'
local color_config    = require 'nd.awesome.config.color'

local key_fn          = require 'nd.awesome.core.key'

local proc            = require 'nd.awesome.proc'

local iv              = fn_lib.iv
local each            = fn_lib.each

local concat2s        = str_lib.concat2s

local clone_with      = tab_lib.clone_with

local is_str          = type_lib.is_str
local is_fn           = type_lib.is_fn

local key_scheme_fn   = key_cache_res.get_awesome
local color_scheme_fn = color_cache_res.get_awesome

local awesome         = awesome
local screen          = screen
local client          = client
local root            = root
local awful           = require 'awful'
local beautiful       = require 'beautiful'
local gears           = require 'gears'
local wibox           = require 'wibox'

local filesystem      = gears.filesystem

local is_init         = false


local set_wallpapers      = nil
local set_tags_properties = nil
local set_tags            = nil
local set_screen          = nil


set_wallpapers = function(s, wp)
    gears.wallpaper.maximized(is_str(wp) and wp or is_fn(wp) and wp(s))
end

set_tags_properties = function(index, s)
    return {
        screen = s,
        selected = index == 1,
        layout = awful.layout.suit.spiral,
    }
end

set_tags = function(s, tags)
    each(function(elem)
        local ind = elem[1]
        local val = elem[2]

        awful.tag.add(val[1], val[2](ind, s))
    end, iv(tags))
end

set_screen = function(key_scheme)
    return function(s)
        set_wallpapers(s, beautiful.wallpaper)
        set_tags(s, {
            { 'X', set_tags_properties },
            { 'X', set_tags_properties },
            { 'X', set_tags_properties },
            { 'X', set_tags_properties },
            { 'X', set_tags_properties },
            { 'X', set_tags_properties },
            { 'X', set_tags_properties },
            { 'X', set_tags_properties },
        })

        local wibar     = awful.wibar {
            screen  = s,
            visible = false,
        }

        local taglist   = awful.widget.taglist
            {
                screen          = s,
                filter          = awful.widget.taglist.filter.all,
                buttons         = key_scheme.button.taglist,

                widget_template = {
                    id     = 'background_role',
                    widget = wibox.container.background,
                    {
                        id           = 'text_role',
                        widget       = wibox.widget.textbox,
                        valign       = 'center',
                        align        = 'center',
                        forced_width = 40,
                    },
                    create_callback = function(self, t, _, _)
                        self:connect_signal('mouse::enter', function()
                            if t ~= awful.screen.focused().selected_tag then
                                self.bg = beautiful.bg_minimize
                            end
                        end)
                        self:connect_signal('mouse::leave', function()
                            if t ~= awful.screen.focused().selected_tag then
                                self.bg = beautiful.bg_normal
                            end
                        end)
                    end,
                    update_callback = function(_, _, _, _)
                    end,
                },
            }

        local tasklist  = awful.widget.tasklist {
            screen          = s,
            filter          = awful.widget.tasklist.filter.currenttags,
            buttons         = key_scheme.button.tasklist,

            layout          = {
                layout = wibox.layout.fixed.horizontal,
            },

            widget_template = {
                id     = 'background_role',
                widget = wibox.container.background,
                {
                    widget = wibox.container.margin,
                    top    = 4,
                    bottom = 4,
                    left   = 6,
                    right  = 6,
                    {
                        id           = 'icon_role',
                        widget       = wibox.widget.imagebox,
                        forced_width = 28,
                    },
                },
                create_callback = function(self, c, _, _)
                    self:connect_signal('mouse::enter', function()
                        if c ~= client.focus and not c.minimized then
                            self.bg = beautiful.bg_minimize
                        end
                    end)
                    self:connect_signal('mouse::leave', function()
                        if c ~= client.focus and not c.minimized then
                            self.bg = beautiful.bg_normal
                        end
                    end)
                end,
                update_callback = function(_, _, _, _)
                end,
            },
        }

        local textclock = wibox.widget.textclock(' %d.%m.%Y %T ', 1)

        wibar:setup {
            widget = wibox.container.background,
            shape  = gears.shape.rectangle,
            bg     = beautiful.bg_normal,
            {
                layout = wibox.layout.align.horizontal,
                taglist,
                tasklist,
                textclock,
            },
        }

        s.wibar = wibar
    end
end

return function()
    if not is_init then
        cache_lib.set_dir(concat2s(filesystem.get_dir 'cache', 'nd.awesome/'))

        proc.uniques {
            { 'udiskie', '' },
            { 'picom',   '' },
        }

        local color_scheme = color_scheme_fn(color_config['main'])
        local key_scheme = key_scheme_fn(clone_with(key_config['main'], {
            event = {
                on_sound = function(val)
                    event_lib.notify('key', 'sound', val)
                end,
                on_light = function(val)
                    event_lib.notify('key', 'light', val)
                end,
                on_tag = function()
                    event_lib.notify('key', 'tag')
                end,
            },
        }))

        root.keys(key_fn(key_scheme.key.root, awful.key))
        root.buttons(key_fn(key_scheme.button.root, awful.button))

        beautiful.init(color_scheme.theme.raw)

        awful.rules.rules = {
            {
                rule = {},
                properties = {
                    raise        = true,
                    keys         = key_fn(key_scheme.key.client, awful.key),
                    buttons      = key_fn(key_scheme.button.client, awful.button),
                    border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus        = awful.client.focus.filter,
                    screen       = awful.screen.preferred,
                    placement    = awful.placement.no_overlap + awful.placement.no_offscreen,
                },
            },
        }

        awesome.set_preferred_icon_size(256)

        awful.screen.connect_for_each_screen(set_screen(key_scheme))

        screen.connect_signal('property::geometry', set_wallpapers)

        is_init = true
    end
end
