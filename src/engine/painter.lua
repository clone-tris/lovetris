---@class EnginePainter
---@field width number
---@field height number
---@field canvas love.Canvas
local EnginePainter = {}
EnginePainter.__index = EnginePainter

---@param width number
---@param height number
function EnginePainter:new(width, height)
  local canvas = love.graphics.newCanvas(width, height)
  return setmetatable({ width = width, height = height, canvas = canvas }, self)
end

return EnginePainter
