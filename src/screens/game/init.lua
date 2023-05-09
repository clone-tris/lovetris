local Sidebar = require("screens.game.sidebar")
local Playfield = require("screens.game.playfield")
local conf = require("conf")

---@class GameScreen
---@field playfield Playfield
---@field sidebar Sidebar
local Game = {}
Game.__index = Game

function Game:new()
  local o = {
    playfield = Playfield:new(conf.WAR_ZONE_WIDTH, conf.CANVAS_HEIGHT),
    sidebar = Sidebar:new(conf.SIDEBAR_WIDTH, conf.CANVAS_HEIGHT),
  }
  setmetatable(o, self)
  return o
end

function Game:paint()
  love.graphics.setCanvas(self.sidebar.painter.canvas)
  self.sidebar:paint()

  love.graphics.setCanvas(self.playfield.painter.canvas)
  self.playfield:paint()

  love.graphics.setCanvas()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.sidebar.painter.canvas, 0, 0)
  love.graphics.draw(self.playfield.painter.canvas, conf.SIDEBAR_WIDTH, 0)
end

return Game
