local conf = require("conf")
local colors = require("colors")

---@class EnginePainter
---@field width number
---@field height number
---@field canvas love.Canvas
local EnginePainter = {}

---@param width number
---@param height number
function EnginePainter:new(width, height)
  local o = {
    width = width,
    height = height,
    canvas = love.graphics.newCanvas(width, height),
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

---@param width number?
---@param height number?
function EnginePainter:drawGuide(width, height)
  width = width and width or self.width
  height = height and height or self.height

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

return EnginePainter
