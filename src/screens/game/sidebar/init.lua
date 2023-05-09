local Screen = require("engine.screen")
local SidebarPainter = require("screens.game.sidebar.painter")

---@class Sidebar: Screen
---@field painter SidebarPainter
local Sidebar = setmetatable({}, { __index = Screen })
Sidebar.__index = Sidebar

---@param width number
---@param height number
function Sidebar:new(width, height)
  local o = setmetatable(Screen:new(), Sidebar)
  o.painter = SidebarPainter:new(width, height)
  return o
end

function Sidebar:paint()
  love.graphics.setCanvas(self.painter.canvas)
  --
  self.painter:draw_background()
  --
  love.graphics.setCanvas()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.painter.canvas, 0, 0)
end

return Sidebar
