---@class Square
local Square = {}
Square.__index = Square

function Square:new(row, column, color)
  local o = { row, column, color }
  setmetatable(o, self)
  return o
end

return Square
