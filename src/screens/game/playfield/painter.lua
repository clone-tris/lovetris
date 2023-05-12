local EnginePainter = require("engine.painter")
local conf = require("conf")
local colors = require("colors")

---@class PlayfieldPainter: EnginePainter
---@field width number
---@field height number
local Painter = setmetatable({}, { __index = EnginePainter })

---@param width number
---@param height number
function Painter:new(width, height)
  local o = EnginePainter:new(width, height)
  setmetatable(o, self)
  self.__index = self

  o.width = width
  o.height = height

  return o
end

function Painter:drawBackground()
  love.graphics.clear(colors.UiColors.BACKGROUND)
end

function Painter:drawGuide()
  local rows = self.height / conf.SQUARE_WIDTH
  local columns = self.width / conf.SQUARE_WIDTH
  for i = 0, (rows + 1) do
    local lineY = i * conf.SQUARE_WIDTH
    love.graphics.setColor(colors.UiColors.GUIDE)
    love.graphics.line(0, lineY, self.width, lineY)
  end
  for i = 0, (columns + 1) do
    local lineX = i * conf.SQUARE_WIDTH
    love.graphics.setColor(colors.UiColors.GUIDE)
    love.graphics.line(lineX, 0, lineX, self.height)
  end
end

return Painter
