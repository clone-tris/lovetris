local Screen = require("engine.screen")
local Painter = require("screens.menu.painter")
local Button = require("engine.components.button")
local Shape = require("screens.game.components.shape")
local Game = require("screens.game")
local graphic = require("screens.menu.graphic")
local colors = require("colors")
local conf = require("conf")

---@class Menu: Screen
---@field painter MenuPainter
---@field graphic Shape
---@field startButton Button
---@field quitButton Button
local Menu = setmetatable({}, { __index = Screen })

function Menu:new()
  local o = Screen:new()
  o.painter = Painter:new()
  o.graphic =
    Shape:new(1, 1, graphic.getGraphicSquareGrid(), colors.SquareColors.DEFAULT_SQUARE_COLOR)

  o.startButton = Button:new("[S]tart", 4 * conf.SQUARE_WIDTH, 17 * conf.SQUARE_WIDTH)
  o.quitButton = Button:new("[Q]uit", 8 * conf.SQUARE_WIDTH, 17 * conf.SQUARE_WIDTH)

  setmetatable(o, self)
  self.__index = self
  return o
end

function Menu:paint()
  self.painter:drawBackground()
  self.painter:drawGuide()
  self.graphic:draw()
  self.startButton:draw()
  self.quitButton:draw()
end

---@param key love.KeyConstant
function Menu:keypressed(key)
  if key == "s" then
    ---@diagnostic disable-next-line: param-type-mismatch
    love.event.push("useScreen", "Game")
  end

  if key == "q" then
    love.event.push("quit")
  end
end

---@param x number
---@param y number
---@param button number
function Menu:mousereleased(x, y, button)
  if button ~= 1 then
    return
  end
  if self.startButton:contains(x, y) then
    ---@diagnostic disable-next-line: param-type-mismatch
    love.event.push("useScreen", "Game")
  end
  if self.quitButton:contains(x, y) then
    love.event.push("quit")
  end
end

return Menu
