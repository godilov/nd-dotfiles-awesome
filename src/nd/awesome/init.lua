local str_lib       = require 'nd.lib.core.str'
local cache_lib     = require 'nd.lib.core.cache.fs'

local key_config    = require 'nd.awesome.config.key'
local color_config  = require 'nd.awesome.config.color'

local navigation_fn = require 'nd.awesome.navigation'
local appearance_fn = require 'nd.awesome.appearance'
local proc          = require 'nd.awesome.proc'

local concat2s      = str_lib.concat2s

local filesystem    = require 'gears.filesystem'

local is_init       = false

return function()
    if not is_init then
        cache_lib.set_dir(concat2s(filesystem.get_dir 'cache', 'nd.awesome/'))

        proc.uniques {
            { 'udiskie', '' },
            { 'picom',   '' },
        }

        local config = {
            key   = key_config['main'],
            color = color_config['main'],
        }

        navigation_fn(config.key)
        appearance_fn(config.color)
    end
end
