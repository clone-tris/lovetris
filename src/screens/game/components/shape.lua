---@class Shape
---@field row number
---@field column number
---@field width number
---@field height number
---@field grid Square[]
local Shape = {}
Shape.__index = Shape

---@param row number
---@param column number
---@param grid Square[]
function Shape:new(row, column, grid)
  local o = { row = row, column = column, grid = grid }
  setmetatable(o, self)
  return o
end

function Shape:draw()
  for _, square in ipairs(self.grid) do
    square:draw()
  end
end

return Shape
