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
  self.sidebar:paint()
  self.playfield:paint()
end

return Game
