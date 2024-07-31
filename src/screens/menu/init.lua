local Screen = require("engine.screen")
local Painter = require("screens.menu.painter")
local Shape = require("screens.game.components.shape")
local graphic = require("screens.menu.graphic")
local colors = require("colors")

---@class Menu: Screen
---@field painter MenuPainter
---@field graphic Shape
local Menu = setmetatable({}, { __index = Screen })

function Menu:new()
  local o = Screen:new()
  o.painter = Painter:new()
  o.graphic =
    Shape:new(1, 1, graphic.getGraphicSquareGrid(), colors.SquareColors.DEFAULT_SQUARE_COLOR)

  setmetatable(o, self)
  self.__index = self
  return o
end

function Menu:paint()
  self.painter:drawBackground()
  self.painter:drawGuide()
  self.graphic:draw()
end

return Menu
