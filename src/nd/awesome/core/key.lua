local fn_lib    = require 'nd.lib.core.fn'

local gears     = require 'gears'

local ivals     = fn_lib.ivals
local map       = fn_lib.map
local collect   = fn_lib.collect

return function(t, fn)
    return gears.table.join(collect(map(fn, ivals(t))))
end
