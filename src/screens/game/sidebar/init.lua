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
  self.painter:draw_background()
end

return Sidebar
