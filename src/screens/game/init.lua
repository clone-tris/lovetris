local Sidebar = require("screens.game.sidebar")
local Playfield = require("screens.game.playfield")
local conf = require("conf")

---@class GameScreen
---@field playfield Playfield
---@field sidebar Sidebar
---@field nextFall number
---@field isPlayerFalling boolean
---@field remainingAfterPaused number
---@field paused boolean
---@field shouldRestart boolean
local Game = {}

---@return GameScreen
function Game:new()
  ---@type GameScreen
  local o = {
    playfield = Playfield:new(conf.WAR_ZONE_WIDTH, conf.CANVAS_HEIGHT),
    sidebar = Sidebar:new(conf.SIDEBAR_WIDTH, conf.CANVAS_HEIGHT),
    isPlayerFalling = false,
    paused = false,
    nextFall = os.timeInMils(),
    remainingAfterPaused = 0,
    showGameOver = false,
    shouldRestart = false,
  }
  setmetatable(o, self)
  self.__index = self
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
  if now >= self.nextFall then
    self:makePlayerFall()
    self.nextFall = now + self.playfield.fallRate
  end
end

function Game:makePlayerFall()
  if self.isPlayerFalling then
    return
  end

  self.isPlayerFalling = true
  local ableToMove = self.playfield:fallDown()
  if (not ableToMove) and self.playfield.isGameEnded then
    self.showGameOver = true
    return
  end

  if (not ableToMove) and self.playfield.onFloor then
    self.nextFall = self.playfield.endOfLock
    self.sidebar.nextPlayer = self.playfield.nextPlayer:copy()
  end
  self.isPlayerFalling = false
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
  self.playfield:resetScore()
end

return Game
