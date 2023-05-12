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
---@field floorRate number
---@field onFloor boolean
---@field isGameEnded boolean
---@field endOfLock number
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
  o.nextPlayer = tetromino.randomTetromino()
  o.score = Score:new()
  o.fallRate = 100
  o.floorRate = 50
  o.onFloor = false
  o.isGameEnded = false
  o.endOfLock = os.timeInMils()

  o:spawnPlayer()

  o.player.row = 4

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
  player.column = math.floor((conf.PUZZLE_WIDTH - player.width) / 2)
  self.player = player
  self.nextPlayer = tetromino:randomTetromino()
end

function Playfield:rotate()
  local forshadow = self.player:copy()
  forshadow:rotate()
  if forshadow:collidesWith(self.opponent) or (not forshadow:withinBounds()) then
    return
  end
  self.player = forshadow
end

---@param rowDirection number
---@param columnDirection number
function Playfield:movePlayer(rowDirection, columnDirection)
  local foreshadow = self.player:copy()
  local movingDown = rowDirection == 1
  foreshadow:translate(rowDirection, columnDirection)
  local ableToMove = (not foreshadow:collidesWith(self.opponent)) and foreshadow:withinBounds()

  if ableToMove then
    self.player = foreshadow
    if movingDown then
      self.onFloor = false
    end
  else
    if movingDown then
      self:handleFallingDown()
    end
  end
  return ableToMove
end

function Playfield:handleFallingDown()
  local time = os.timeInMils()
  if not self.onFloor then
    self.onFloor = true
    self.endOfLock = time + self.floorRate
    return
  else
    if time < self.endOfLock then
      return
    end
  end

  self:eatPlayer()
  self:spawnPlayer()

  if self.player:collidesWith(self.opponent) then
    self.game_ended = true
  end
end

function Playfield:fallDown()
  return self:movePlayer(1, 0)
end

return Playfield
