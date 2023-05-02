local conf = require "conf"

local Playfield = {}

Playfield.paint = function()
    love.graphics.setColor(0, 122, 0)
    love.graphics.rectangle(
        "fill",
        conf.SIDEBAR_WIDTH,
        0,
        conf.WAR_ZONE_WIDTH,
        conf.CANVAS_HEIGHT
    )
end

return Playfield
