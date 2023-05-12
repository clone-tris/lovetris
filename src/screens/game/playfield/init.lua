local conf = require("conf")
local colors = require("colors")
local Screen = require("engine.screen")
local Painter = require("screens.game.playfield.painter")
local Shape = require("screens.game.components.shape")
local Score = require("screens.game.components.score")
local tetromino = require("screens.game.components.tetromino")
local utils = require("utils")

---@class Playfield: Screen
---@field painter PlayfieldPainter
---@field player Shape
---@field nextPlayer Shape
---@field opponent Shape
---@field score Score
---@field fallRate number
local Playfield = setmetatable({}, { __index = Screen })

---@param width number
---@param height number
function Playfield:new(width, height)
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
  o.nextPlayer = tetromino.randomTetromino()
  o.score = Score:new()

  o.spawnPlayer(o)

  local a = tetromino.getTetromino("I")
  local b = tetromino.getTetromino("I")
  local c = tetromino.getTetromino("O")
  local a2 = tetromino.getTetromino("I")
  local b2 = tetromino.getTetromino("I")

  a.row = conf.PUZZLE_HEIGHT - 1
  b.row = conf.PUZZLE_HEIGHT - 1
  b.column = 4
  c.row = conf.PUZZLE_HEIGHT - 2
  c.column = 8

  a2.row = conf.PUZZLE_HEIGHT - 2
  b2.row = conf.PUZZLE_HEIGHT - 2
  b2.column = 4

  -- o.opponent:eat(a)
  -- o.opponent:eat(b)
  -- o.opponent:eat(c)
  -- o.opponent:eat(a2)
  -- o.opponent:eat(b2)

  -- print(o.opponent:removeFullLines())

  return o
end

function Playfield:paint()
  self.painter:drawBackground()

  self.painter:drawGuide()
  self.opponent:draw()
  self.player:draw()
end

function Playfield:eatPlayer()
  self.opponent:eat(self.player:copy())
  local linesRemoved = self.opponent:removeFullLines()
  if linesRemoved == 0 then
    return
  end

  local currentLevel = self.score.level
  self:applyScore(linesRemoved)
  if currentLevel ~= self.score.level then
    self.fallRate = self.fallRate - self.fallRate / 3
  end
end

---@param linesRemoved number
function Playfield:applyScore(linesRemoved)
  local points = Score.pointsTable[linesRemoved]

  points = points * (self.score.level + 1)

  self.score.total = self.score.total + points
  self.score.linesCleared = self.score.linesCleared + linesRemoved
  self.score.level = math.floor(self.score.linesCleared / 10) + 1
end

function Playfield:resetScore()
  self.score = Score:new()
end

function Playfield:spawnPlayer()
  local player = self.nextPlayer:copy()
  player.row = player.row - player.height
  player.column = (conf.PUZZLE_WIDTH - player.width) / 2
  self.player = player
  self.nextPlayer = tetromino:randomTetromino()
end

return Playfield
