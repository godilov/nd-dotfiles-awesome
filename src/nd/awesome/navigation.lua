local cache_res = require 'nd.res.key.cache'

local scheme_fn = cache_res.get_awesome

return function(key_config)
    local scheme = scheme_fn(key_config)

    root.keys(scheme.key.root)
    root.buttons(scheme.button.root)
end
