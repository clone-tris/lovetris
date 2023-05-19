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

  love.graphics.setCanvas(self.nextPlayerCanvas)
  love.graphics.clear(colors.UiColors.SIDEBAR_BACKGROUND)
  self.nextPlayer:draw()

  love.graphics.setCanvas(self.painter.canvas)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.nextPlayerCanvas, conf.SQUARE_WIDTH, conf.SQUARE_WIDTH)
end

return Sidebar
