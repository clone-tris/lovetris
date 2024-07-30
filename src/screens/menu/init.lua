local Screen = require("engine.screen")
local Painter = require("screens.menu.painter")

---@class Menu: Screen
---@field painter MenuPainter
local Menu = setmetatable({}, { __index = Screen })

function Menu:new()
  local o = Screen:new()
  o.painter = Painter:new()

  setmetatable(o, self)
  self.__index = self
  return o
end

function Menu:paint()
  self.painter:drawBackground()
end

return Menu
