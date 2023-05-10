local conf = require("conf")

---@class Shape
---@field row number
---@field column number
---@field width number
---@field height number
---@field squares Square[]
local Shape = {}
Shape.__index = Shape

---@param row number
---@param column number
---@param squares Square[]
function Shape:new(row, column, squares)
  local o = { row = row, column = column, squares = squares }
  setmetatable(o, self)
  return o
end

function Shape:draw()
  for _, square in ipairs(self.squares) do
    square:draw()
  end
end

function Shape:computeSize()
  local minRow = conf.PUZZLE_HEIGHT
  local maxRow = 0
  local minColumn = conf.PUZZLE_WIDTH
  local maxColumn = 0

  for _, square in ipairs(self.squares) do
    square:draw()
  end
end

return Shape
