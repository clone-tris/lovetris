local M = {}

local conf = require("conf")
local colors = require("colors")

M.draw_background = function()
  love.graphics.setColor(colors.UiColors.BACKGROUND)
  love.graphics.rectangle(
    "fill",
    conf.SIDEBAR_WIDTH,
    0,
    conf.WAR_ZONE_WIDTH,
    conf.CANVAS_HEIGHT
  )
end

return M
