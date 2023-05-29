local cache_res = require 'nd.res.color.cache'

local interface = require 'nd.awesome.core.interface'

local scheme_fn = cache_res.get_awesome

local awful     = require 'awful'
local beautiful = require 'beautiful'
local gears     = require 'gears'
local wibox     = require 'wibox'
local naughty   = require 'naughty'
local menubar   = require 'menubar'

return function(key_config, color_config)
    local scheme = scheme_fn(color_config)

    beautiful.init(scheme.theme.raw)
end
