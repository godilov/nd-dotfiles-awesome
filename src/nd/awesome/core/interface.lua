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
    container = {
        arcchart          = fn('container', container.arcchart),
        background        = fn('container', container.background),
        constraint        = fn('container', container.constraint),
        margin            = fn('container', container.margin),
        mirror            = fn('container', container.mirror),
        only_on_screen    = fn('container', container.only_on_screen),
        place             = fn('container', container.place),
        radialprogressbar = fn('container', container.radialprogressbar),
        rotate            = fn('container', container.rotate),
        scroll            = fn('container', container.scroll),
    },
    layout = {
        align  = fn('layout', layout.align),
        fixed  = fn('layout', layout.fixed),
        flex   = fn('layout', layout.flex),
        grid   = fn('layout', layout.grid),
        manual = fn('layout', layout.manual),
        ratio  = fn('layout', layout.ratio),
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
        textbox     = fn('widget', widget.textbox),
    },
}
