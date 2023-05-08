local conf = require("conf")
local colors = require("colors")

local Sidebar = {}

Sidebar.paint = function()
  love.graphics.setColor(colors.UiColors.SIDEBAR_BACKGROUND)
  love.graphics.rectangle("fill", 0, 0, conf.SIDEBAR_WIDTH, conf.CANVAS_HEIGHT)
end

return Sidebar
