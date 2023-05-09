---@class Shape
local Shape = {}
Shape.__index = Shape

function Shape:new(row, column, color)
  local o = { row, column, color }
  setmetatable(o, self)
  return o
end

return Shape
