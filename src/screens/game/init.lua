local conf = require("conf")
local Screen = require("engine.screen")
local Sidebar = require("screens.game.sidebar")
local Playfield = require("screens.game.playfield")
local Score = require("screens.game.components.score")
local tetromino = require("screens.game.components.tetromino")

---@class GameScreen: Screen
---@field playfield Playfield
---@field sidebar Sidebar
---@field paused boolean
---@field shouldRestart boolean
---@field isPlayerFalling boolean
---@field isMoppingTheFloor boolean
---@field onFloor boolean
---@field nextFall number
---@field remainingAfterPaused number
---@field score Score
---@field fallRate number
---@field floorRate number
---@field keysTable table<love.KeyConstant,function>
local Game = setmetatable({}, { __index = Screen })

---@return GameScreen
function Game:new()
  ---@type GameScreen
  local o = Screen:new()
  setmetatable(o, self)
  self.__index = self

  local score = Score:new()

  o.playfield = Playfield:new(conf.WAR_ZONE_WIDTH, conf.CANVAS_HEIGHT)
  o.sidebar = Sidebar:new(conf.SIDEBAR_WIDTH, conf.CANVAS_HEIGHT, score)
  o.paused = false
  o.showGameOver = false
  o.isPlayerFalling = false
  o.isMoppingTheFloor = false
  o.onFloor = false
  o.shouldRestart = false
  o.nextFall = os.timeInMils()
  o.remainingAfterPaused = 0
  o.floorRate = 500
  o.fallRate = 1000
  o.score = score
  o.keysTable = {
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

  o:spawnPlayer()
  o:updateScoreText()

  return o
end

function Game:paint()
  self.sidebar:paint()
  self.playfield:paint()
  love.graphics.setCanvas()
  --
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

---@param key love.KeyConstant
function Game:keypressed(key)
  if self.keysTable[key] == nil then
    return
  end
  self.keysTable[key](self)
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
      self.showGameOver = true

      love.graphics.captureScreenshot(function(imgData)
        local canvasImage = love.graphics.newImage(imgData)

        ---@diagnostic disable-next-line: param-type-mismatch
        love.event.push("useScreen", "Over", canvasImage)
      end)

      return
    end
  end

  self.onFloor = false
  self.isMoppingTheFloor = false
end

function Game:spawnPlayer()
  local player = self.sidebar.nextPlayer:copy()
  player.row = player.row - player.height
  player.column = math.floor((conf.PUZZLE_WIDTH - player.width) / 2)
  self.playfield.player = player
  self.sidebar.nextPlayer = tetromino:randomTetromino()
end

---@param linesRemoved number
function Game:applyScore(linesRemoved)
  local basePoints = Score.pointsTable[linesRemoved]
  local linesCleared = self.score.linesCleared + linesRemoved
  local level = math.floor(linesCleared / 10) + 1
  local points = basePoints * (level + 1)
  local total = self.score.total + points

  self.score.level = level
  self.score.linesCleared = linesCleared
  self.score.total = total

  self:updateScoreText()
end

function Game:updateScoreText()
  self.score.levelText:set(string.format("Level\n%d", self.score.level))
  self.score.linesClearedText:set(string.format("Cleared\n%d", self.score.linesCleared))
  self.score.totalText:set(string.format("Score\n%d", self.score.total))
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

return Game
