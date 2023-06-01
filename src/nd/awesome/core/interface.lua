local wibox     = require 'wibox'

local container = wibox.container
local layout    = wibox.layout
local widget    = wibox.widget

local unpack    = table.unpack


local fn = nil


fn = function(key, val)
    return function(t)
        return {
            [key] = val,
            unpack(t),
        }
    end
end

return {
    raw = {
        container = {
            arcchart          = fn('container', container.arcchart),
            background        = fn('container', container.background),
            constraint        = fn('container', container.constraint),
            margin            = fn('container', container.margin),
            mirror            = fn('container', container.mirror),
            place             = fn('container', container.place),
            radialprogressbar = fn('container', container.radialprogressbar),
            rotate            = fn('container', container.rotate),
            scroll            = fn('container', container.scroll),
        },
        layout = {
            align  = {
                horizontal = fn('layout', layout.align.horizontal),
                vertical   = fn('layout', layout.align.vertical),
            },
            fixed  = {
                horizontal = fn('layout', layout.fixed.horizontal),
                vertical   = fn('layout', layout.fixed.vertical),
            },
            flex   = {
                horizontal = fn('layout', layout.flex.horizontal),
                vertical   = fn('layout', layout.flex.vertical),
            },
            grid   = fn('layout', layout.grid),
            manual = fn('layout', layout.manual),
            ratio  = {
                horizontal = fn('layout', layout.ratio.horizontal),
                vertical   = fn('layout', layout.ratio.vertical),
            },
            stack  = fn('layout', layout.stack),
        },
        widget = {
            calendar    = fn('widget', widget.calendar),
            checkbox    = fn('widget', widget.checkbox),
            graph       = fn('widget', widget.graph),
            imagebox    = fn('widget', widget.imagebox),
            piechart    = fn('widget', widget.piechart),
            progressbar = fn('widget', widget.progressbar),
            separator   = fn('widget', widget.separator),
            slider      = fn('widget', widget.slider),
            systray     = fn('widget', widget.systray),
            textbox     = fn('widget', widget.textbox),
            textclock   = fn('widget', widget.textclock),
        },
    },
}
