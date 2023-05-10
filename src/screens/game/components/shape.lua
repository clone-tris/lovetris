---@class Shape
---@field row number
---@field column number
---@field color Color
local Shape = {}
Shape.__index = Shape

---@param row number
---@param column number
---@param color Color
function Shape:new(row, column, color)
  local o = { row = row, column = column, color = color }
  setmetatable(o, self)
  return o
end

return Shape
