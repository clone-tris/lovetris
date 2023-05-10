---@class Square
---@field row number
---@field column number
---@field color Color
local Square = {}
Square.__index = Square

---@param row number
---@param column number
---@param color Color
function Square:new(row, column, color)
  local o = { row, column, color }
  setmetatable(o, self)
  return o
end

return Square
