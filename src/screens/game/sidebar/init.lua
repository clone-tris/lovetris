local conf = require("conf")

local Sidebar = {}

Sidebar.paint = function()
  love.graphics.setColor(0, 0, 166)
  love.graphics.rectangle("fill", 0, 0, conf.SIDEBAR_WIDTH, conf.CANVAS_HEIGHT)
end

return Sidebar
