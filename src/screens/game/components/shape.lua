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

  if #squares > 0 then
    self.computeDimensions(o)
  end

  return o
end

function Shape:draw()
  for _, square in ipairs(self.squares) do
    square:draw()
  end
end

function Shape:computeDimensions()
  local minRow = conf.PUZZLE_HEIGHT
  local maxRow = 0
  local minColumn = conf.PUZZLE_WIDTH
  local maxColumn = 0

  for _, square in ipairs(self.squares) do
    if square.row > maxRow then
      maxRow = square.row
    end
    if square.column > maxColumn then
      maxColumn = square.column
    end
    if square.row < minRow then
      minRow = square.row
    end
    if square.column < minColumn then
      minColumn = square.column
    end
  end

  self.height = maxRow - minRow + 1
  self.width = maxColumn - minRow + 1
end

return Shape
