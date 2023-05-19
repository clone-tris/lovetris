local conf = require("conf")
local Sidebar = require("screens.game.sidebar")
local Playfield = require("screens.game.playfield")
local Score = require("screens.game.components.score")
local tetromino = require("screens.game.components.tetromino")

---@class GameScreen
---@field playfield Playfield
---@field sidebar Sidebar
---@field nextPlayer Shape
---@field paused boolean
---@field isGameEnded boolean
---@field shouldRestart boolean
---@field isPlayerFalling boolean
---@field isMoppingTheFloor boolean
---@field onFloor boolean
---@field nextFall number
---@field remainingAfterPaused number
---@field score Score
---@field fallRate number
---@field floorRate number
local Game = {}

---@return GameScreen
function Game:new()
  ---@type GameScreen
  local o = {
    playfield = Playfield:new(conf.WAR_ZONE_WIDTH, conf.CANVAS_HEIGHT),
    sidebar = Sidebar:new(conf.SIDEBAR_WIDTH, conf.CANVAS_HEIGHT),
    nextPlayer = tetromino.randomTetromino(),
    paused = false,
    isGameEnded = false,
    showGameOver = false,
    isPlayerFalling = false,
    isMoppingTheFloor = false,
    onFloor = false,
    shouldRestart = false,
    nextFall = os.timeInMils(),
    remainingAfterPaused = 0,
    floorRate = 500,
    fallRate = 1000,
    score = Score:new(),
  }
  setmetatable(o, self)
  self.__index = self

  o:spawnPlayer()
  return o
end

function Game:paint()
  --
  love.graphics.setCanvas(self.sidebar.painter.canvas)
  self.sidebar:paint()

  love.graphics.setCanvas(self.playfield.painter.canvas)
  self.playfield:paint()
  --
  love.graphics.setCanvas()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.sidebar.painter.canvas, 0, 0)
  love.graphics.draw(self.playfield.painter.canvas, conf.SIDEBAR_WIDTH, 0)
end

function Game:update()
  if self.paused or self.showGameOver then
    return
  end

  self:applyGravity()
end

function Game:applyGravity()
  local now = os.timeInMils()
  if now < self.nextFall then
    return
  end

  if self.onFloor then
    self:mopTheFloor()
  else
    self:makePlayerFall()
  end
end

function Game:makePlayerFall()
  if self.paused or self.isPlayerFalling then
    return
  end
  self.isPlayerFalling = true

  local ableToMove = self:movePlayerDown()

  local now = os.timeInMils()
  if ableToMove then
    self.onFloor = false
    self.nextFall = now + self.fallRate
  else
    self.onFloor = true
    self.endOfLock = now + self.floorRate
    self.nextFall = self.endOfLock
  end

  self.isPlayerFalling = false
end

function Game:mopTheFloor()
  local time = os.timeInMils()
  if time < self.endOfLock or self.paused or self.isMoppingTheFloor then
    return
  end
  self.isMoppingTheFloor = true

  local ableToMove = self:movePlayerDown()
  if not ableToMove then
    self:eatPlayer()
    self:spawnPlayer()

    if self.playfield.player:collidesWith(self.playfield.opponent) then
      self.isGameEnded = true
      self.showGameOver = true
    end
  end

  self.onFloor = false
  self.isMoppingTheFloor = false
end

function Game:spawnPlayer()
  local player = self.nextPlayer:copy()
  player.row = player.row - player.height
  player.column = math.floor((conf.PUZZLE_WIDTH - player.width) / 2)
  self.playfield.player = player
  self.nextPlayer = tetromino:randomTetromino()
end

---@param linesRemoved number
function Game:applyScore(linesRemoved)
  local points = Score.pointsTable[linesRemoved]

  points = points * (self.score.level + 1)

  self.score.total = self.score.total + points
  self.score.linesCleared = self.score.linesCleared + linesRemoved
  self.score.level = math.floor(self.score.linesCleared / 10) + 1
end

function Game:resetScore()
  self.score = Score:new()
end

---@param rowDirection number
---@param columnDirection number
function Game:movePlayer(rowDirection, columnDirection)
  if self.paused then
    return
  end
  local foreshadow = self.playfield.player:copy()
  foreshadow:translate(rowDirection, columnDirection)
  local ableToMove = not foreshadow:collidesWith(self.playfield.opponent)
    and foreshadow:withinBounds()

  if ableToMove then
    self.playfield.player = foreshadow
  end

  return ableToMove
end

function Game:rotatePlayer()
  if self.paused then
    return
  end

  local forshadow = self.playfield.player:copy()
  forshadow:rotate()
  if forshadow:collidesWith(self.playfield.opponent) or (not forshadow:withinBounds()) then
    return
  end
  self.playfield.player = forshadow
end

function Game:movePlayerLeft()
  self:movePlayer(0, -1)
end

function Game:movePlayerRight()
  self:movePlayer(0, 1)
end

function Game:movePlayerDown()
  return self:movePlayer(1, 0)
end

function Game:eatPlayer()
  self.playfield.opponent:eat(self.playfield.player:copy())
  local linesRemoved = self.playfield.opponent:removeFullLines()
  if linesRemoved == 0 then
    return
  end

  local currentLevel = self.score.level
  self:applyScore(linesRemoved)
  if currentLevel ~= self.score.level then
    self.fallRate = self.fallRate - self.fallRate / 3
  end
end

function Game:togglePaused()
  self.paused = not self.paused
  if self.paused then
    local now = os.timeInMils()
    self.remainingAfterPaused = now < self.nextFall and self.nextFall - now or 0
  end
end

function Game:restart()
  self.shouldRestart = true
  self:resetScore()
end

local keysTable = {
  ["w"] = Game.rotatePlayer,
  ["up"] = Game.rotatePlayer,
  ["space"] = Game.rotatePlayer,
  ["a"] = Game.movePlayerLeft,
  ["left"] = Game.movePlayerLeft,
  ["d"] = Game.movePlayerRight,
  ["right"] = Game.movePlayerRight,
  ["s"] = Game.movePlayerDown,
  ["down"] = Game.movePlayerDown,
  ["r"] = Game.restart,
  ["p"] = Game.togglePaused,
}

---@param key string
function Game:keypressed(key)
  if keysTable[key] == nil then
    return
  end
  keysTable[key](self)
end

return Game
