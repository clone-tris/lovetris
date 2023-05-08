local M = {}

local Square = {}
Square.__index = Square

function Square.new(row, column, color)
  return setmetatable({ row, column, color }, Square)
end

return M
