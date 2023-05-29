local cache_res = require 'nd.res.key.cache'

local key_fn    = require 'nd.awesome.core.key'

local scheme_fn = cache_res.get_awesome

local awful     = require 'awful'

return function(key_config)
    local scheme = scheme_fn(key_config)

    root.keys(key_fn(scheme.key.root, awful.key))
    root.buttons(key_fn(scheme.button.root, awful.button))
end
