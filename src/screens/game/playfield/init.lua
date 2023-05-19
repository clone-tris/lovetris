local conf = require("conf")
local colors = require("colors")
local Screen = require("engine.screen")
local Painter = require("screens.game.playfield.painter")
local Shape = require("screens.game.components.shape")
local tetromino = require("screens.game.components.tetromino")

---@class Playfield: Screen
---@field painter PlayfieldPainter
---@field player Shape
---@field opponent Shape
local Playfield = setmetatable({}, { __index = Screen })

---@param width number
---@param height number
function Playfield:new(width, height)
  ---@type Playfield
  local o = Screen:new()
  setmetatable(o, self)
  self.__index = self

  o.painter = Painter:new(width, height)
  o.opponent = Shape:new(
    0,
    0,
    {},
    colors.SquareColors.DEFAULT_SQUARE_COLOR,
    { width = conf.PUZZLE_WIDTH, height = conf.PUZZLE_HEIGHT }
  )
  o.player = tetromino.randomTetromino()

  return o
end

function Playfield:paint()
  self.painter:drawBackground()
  self.painter:drawGuide()
  self.opponent:draw()
  self.player:draw()
end

return Playfield
