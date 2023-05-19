local Screen = require("engine.screen")
local SidebarPainter = require("screens.game.sidebar.painter")
local tetromino = require("screens.game.components.tetromino")
local conf = require("conf")
local colors = require("colors")

---@class Sidebar: Screen
---@field painter SidebarPainter
---@field nextPlayer Shape
---@field nextPlayerCanvas love.Canvas
local Sidebar = setmetatable({}, { __index = Screen })

---@param width number
---@param height number
function Sidebar:new(width, height)
  local o = Screen:new()
  setmetatable(o, self)
  self.__index = self

  o.painter = SidebarPainter:new(width, height)
  o.nextPlayer = tetromino.randomTetromino()
  o.nextPlayerCanvas = love.graphics.newCanvas(4 * conf.SQUARE_WIDTH, 2 * conf.SQUARE_WIDTH)
  return o
end

function Sidebar:paint()
  self.painter:drawBackground()
  self.painter:drawNextPlayer(self.nextPlayerCanvas, self.nextPlayer)
end

return Sidebar
