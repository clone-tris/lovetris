local M = {}

local Shape = {}
Shape.__index = Shape

function Shape.new(row, column, color)
  return setmetatable({ row, column, color }, Shape)
end

return M
