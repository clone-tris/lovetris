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
  love.graphics.clear(colors.UiColors.BACKGROUND)
  self:drawGuide()
  nextPlayer:draw()

  love.graphics.setCanvas(self.canvas)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(nextPlayerCanvas, conf.SQUARE_WIDTH, conf.SQUARE_WIDTH)
end

local font = love.graphics.newFont(14)
local scoreText = love.graphics.newText(font)
local linesClearedText = love.graphics.newText(font)
local totalText = love.graphics.newText(font)

---@param score Score
function Painter:drawScore(score)
  -- todo: remove text updates from paint function
  scoreText:set(string.format("Level\n%d", score.level))
  love.graphics.draw(scoreText, conf.SQUARE_WIDTH / 3, conf.SQUARE_WIDTH * 4)

  linesClearedText:set(string.format("Cleared\n%d", score.linesCleared))
  love.graphics.draw(linesClearedText, conf.SQUARE_WIDTH / 3, conf.SQUARE_WIDTH * 6)

  totalText:set(string.format("Score\n%d", score.total))
  love.graphics.draw(totalText, conf.SQUARE_WIDTH / 3, conf.SQUARE_WIDTH * 8)
end

return Painter
