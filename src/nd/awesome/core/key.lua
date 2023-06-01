local fn_lib  = require 'nd.lib.core.fn'
local tab_lib = require 'nd.lib.core.tab'

local ivals   = fn_lib.ivals
local map     = fn_lib.map
local collect = fn_lib.collect

local merge   = tab_lib.merge

return function(t, fn)
    return merge(collect(map(function(elem)
        return fn(elem[1], elem[2], elem[3], elem[4], elem[5])
    end, ivals(t))))
end
