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

return EnginePainter
