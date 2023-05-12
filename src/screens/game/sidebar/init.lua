local Screen = require("engine.screen")
local SidebarPainter = require("screens.game.sidebar.painter")

---@class Sidebar: Screen
---@field painter SidebarPainter
local Sidebar = setmetatable({}, { __index = Screen })

---@param width number
---@param height number
function Sidebar:new(width, height)
  local o = Screen:new()
  setmetatable(o, self)
  self.__index = self

  o.painter = SidebarPainter:new(width, height)

  return o
end

function Sidebar:paint()
  self.painter:draw_background()
end

return Sidebar
