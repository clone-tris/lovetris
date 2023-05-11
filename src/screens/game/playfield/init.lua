local conf = require("conf")
local colors = require("colors")
local Screen = require("engine.screen")
local Painter = require("screens.game.playfield.painter")
local Shape = require("screens.game.components.shape")
local Square = require("screens.game.components.square")
local tetromino = require("screens.game.components.tetromino")
local utils = require("utils")

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
  o.player = tetromino.randomTetromino()
  return o
end

function Playfield:paint()
  self.painter:drawBackground()
  self.painter:drawGuide()
  self.player:draw()
end

return Playfield
