local Screen = require("engine.screen")
local SidebarPainter = require("screens.game.sidebar.painter")
local tetromino = require("screens.game.components.tetromino")
local conf = require("conf")
local colors = require("colors")

---@class Sidebar: Screen
---@field painter SidebarPainter
---@field nextPlayer Shape
---@field nextPlayerCanvas love.Canvas
---@field score Score
local Sidebar = setmetatable({}, { __index = Screen })

---@param width number
---@param height number
---@param score Score
function Sidebar:new(width, height, score)
  local o = Screen:new()
  o.painter = SidebarPainter:new(width, height)
  o.nextPlayer = tetromino.randomTetromino()
  o.nextPlayerCanvas = love.graphics.newCanvas(4 * conf.SQUARE_WIDTH, 2 * conf.SQUARE_WIDTH)
  o.score = score

  setmetatable(o, self)
  self.__index = self
  return o
end

function Sidebar:paint()
  self.painter:drawBackground()
  self.painter:drawNextPlayer(self.nextPlayerCanvas, self.nextPlayer)
  self.painter:drawScore(self.score)
end

return Sidebar
