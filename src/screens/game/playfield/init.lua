local conf = require("conf")
local colors = require("colors")
local Screen = require("engine.screen")
local Painter = require("screens.game.playfield.painter")
local Shape = require("screens.game.components.shape")
local Square = require("screens.game.components.square")
local tetromino = require("screens.game.components.tetromino")
local utils = require("utils")

---@class Playfield: Screen
---@field painter PlayfieldPainter
---@field player Shape
---@field opponent Shape
local Playfield = setmetatable({}, { __index = Screen })
Playfield.__index = Playfield

---@param width number
---@param height number
function Playfield:new(width, height)
  local o = setmetatable(Screen:new(), Playfield)
  o.painter = Painter:new(width, height)
  o.opponent = Shape:new(
    0,
    0,
    true and {} or tetromino.randomTetromino().squares,
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
