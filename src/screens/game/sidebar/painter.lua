local EnginePainter = require("engine.painter")
local conf = require("conf")
local colors = require("colors")

---@class SidebarPainter: EnginePainter
local Painter = setmetatable({}, { __index = EnginePainter })

---@param width number
---@param height number
function Painter:new(width, height)
  local o = EnginePainter:new(width, height)
  setmetatable(o, self)
  self.__index = self

  return o
end

function Painter:drawBackground()
  love.graphics.clear(colors.UiColors.SIDEBAR_BACKGROUND)
end

---@param nextPlayerCanvas love.Canvas
---@param nextPlayer Shape
function Painter:drawNextPlayer(nextPlayerCanvas, nextPlayer)
  love.graphics.setCanvas(nextPlayerCanvas)
  love.graphics.clear(colors.UiColors.SIDEBAR_BACKGROUND)
  nextPlayer:draw()

  love.graphics.setCanvas(self.canvas)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(nextPlayerCanvas, conf.SQUARE_WIDTH, conf.SQUARE_WIDTH)
end

return Painter
