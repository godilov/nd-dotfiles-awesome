local awesome   = awesome
local screen    = screen
local client    = client
local root      = root
local awful     = require 'awful'
local beautiful = require 'beautiful'
local gears     = require 'gears'
local wibox     = require 'wibox'
local naughty   = require 'naughty'
local menubar   = require 'menubar'

return {
    ['main'] = {
        scheme = 'main',
        mod = {
            keyboard = {
                alt   = 'Mod1',
                ctrl  = 'Control',
                shift = 'Shift',
                super = 'Mod4',
                enter = 'Return',
                space = 'space',
            },
            mouse = {
                left        = 1,
                right       = 3,
                roller      = 2,
                roller_up   = 4,
                roller_down = 5,
                side_next   = 9,
                side_prev   = 8,
            },
        },
        api = {
            awesome   = awesome,
            screen    = screen,
            client    = client,
            root      = root,
            awful     = awful,
            beautiful = beautiful,
            gears     = gears,
            wibox     = wibox,
            naughty   = naughty,
            menubar   = menubar,
        },
    },
}
