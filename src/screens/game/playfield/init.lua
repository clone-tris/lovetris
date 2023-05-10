local conf = require("conf")
local colors = require("colors")
local Screen = require("engine.screen")
local Painter = require("screens.game.playfield.painter")
local Shape = require("screens.game.components.shape")
local Square = require("screens.game.components.square")
local tetromino = require("screens.game.components.tetromino")

---@class Playfield: Screen
---@field painter Painter
---@field player Shape
---@field opponent Shape
local Playfield = setmetatable({}, { __index = Screen })
Playfield.__index = Playfield

---@param width number
---@param height number
function Playfield:new(width, height)
  local o = setmetatable(Screen:new(), Playfield)
  o.painter = Painter:new(width, height)
  o.player = Shape:new(0, 0, {
    Square:new(1, 1, colors.TetrominoColors.BLUE),
    Square:new(1, 2, colors.TetrominoColors.BLUE),
    Square:new(2, 3, colors.TetrominoColors.BLUE),
    Square:new(4, 5, colors.TetrominoColors.BLUE),
    Square:new(5, 1, colors.TetrominoColors.BLUE),
  })
  return o
end

print(tetromino.randomTetromino())

function Playfield:paint()
  self.painter:drawBackground()
  self.painter:drawGuide()
  self.player:draw()
end

return Playfield
