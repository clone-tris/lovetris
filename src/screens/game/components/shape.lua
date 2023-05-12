local conf = require("conf")

---@class Shape
---@field row number
---@field column number
---@field width number
---@field height number
---@field color Color
---@field squares Square[]
local Shape = {}

---@param row number
---@param column number
---@param squares Square[]
---@param color Color
---@param size? {width: number, height: number}
---@return Shape
function Shape:new(row, column, squares, color, size)
  local o = {
    row = row,
    column = column,
    squares = squares,
    color = color,
    width = size and size.width or 0,
    height = size and size.height or 0,
  }

  if #o.squares > 0 and size == nil then
    self.computeSize(o)
  end

  setmetatable(o, self)
  self.__index = self

  return o
end

function Shape:draw()
  for _, square in ipairs(self.squares) do
    square:draw(self.row, self.column)
  end
end

function Shape:computeSize()
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

---@param rowDirection number
---@param columnDirection number
function Shape:translate(rowDirection, columnDirection)
  self.row = self.row + rowDirection
  self.column = self.column + columnDirection
end

function Shape:copy()
  local squaresCopy = {}
  for _, square in ipairs(self.squares) do
    table.insert(squaresCopy, square:copy())
  end

  local copy = Shape:new(
    self.row,
    self.column,
    squaresCopy,
    self.color,
    { width = self.width, height = self.height }
  )

  return copy
end

---@return Square[]
function Shape:absoluteGrid()
  local grid = {}
  for _, square in ipairs(self.squares) do
    local absoluteSquare = square:copy()
    absoluteSquare.row = square.row + self.row
    absoluteSquare.column = square.column + self.column
    table.insert(grid, absoluteSquare)
  end
  return grid
end

---@param b Shape
function Shape:collidesWith(b)
  for _, squareA in ipairs(self:absoluteGrid()) do
    for _, squareB in ipairs(b:absoluteGrid()) do
      if squareB.row == squareA.row and squareB.column == squareA.column then
        return true
      end
    end
  end
  return false
end

---@param pray Shape
function Shape:eat(pray)
  local newGrid = self:copy().squares
  local prayGrid = pray:absoluteGrid()

  for _, praySquare in ipairs(prayGrid) do
    table.insert(newGrid, praySquare)
  end

  self.squares = newGrid
end

function Shape:withinBounds()
  for _, square in ipairs(self:absoluteGrid()) do
    if
      square.column < 0
      or square.column >= conf.PUZZLE_WIDTH
      or square.row >= conf.PUZZLE_HEIGHT
    then
      return false
    end
  end
  return true
end

function Shape:rotate()
  local newSquares = {}
  for _, square in ipairs(self.squares) do
    local newSquare = square:copy()
    newSquare.row = square.column
    newSquare.column = self.height - square.row - 1
    table.insert(newSquares, newSquare)
  end

  self.squares = newSquares

  self:computeSize()
end

function Shape:removeFullLines()
  local fullRows = self:findFullRows()
  if #fullRows == 0 then
    return 0
  end

  local newGrid = {}

  for _, square in ipairs(self.squares) do
    if table.contains(fullRows, square.row) then
      goto continue
    end
    local copy = square:copy()
    local rowBeforeShifting = copy.row
    for _, fullRow in ipairs(fullRows) do
      if fullRow > rowBeforeShifting then
        copy.row = copy.row + 1
      end
    end

    table.insert(newGrid, copy)
    ::continue::
  end
  self.squares = newGrid

  return #fullRows
end

function Shape:findFullRows()
  ---@type number[]
  local fullRows = {}
  ---@type table<number, number>
  local populationDict = {}

  for _, square in ipairs(self.squares) do
    local rowPopulation = populationDict[square.row]
    rowPopulation = rowPopulation == nil and 1 or rowPopulation + 1
    populationDict[square.row] = rowPopulation

    if rowPopulation == conf.PUZZLE_WIDTH then
      table.insert(fullRows, square.row)
    end
  end

  return fullRows
end

return Shape
