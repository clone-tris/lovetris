local conf = require("conf")
local colors = require("colors")
---@class Square
---@field row number
---@field column number
---@field color Color
local Square = {}
Square.__index = Square

---@param row number
---@param column number
---@param color Color
---@return Square
function Square:new(row, column, color)
  local o = { row = row, column = column, color = color }
  setmetatable(o, self)
  return o
end

---@param refRow number
---@param refColumn number
function Square:draw(refRow, refColumn)
  local WIDTH = conf.SQUARE_WIDTH
  local BORDER_WIDTH = conf.SQUARE_BORDER_WIDTH
  local x = (refColumn + self.column) * WIDTH
  local y = (refRow + self.row) * WIDTH

  -- background
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", x, y, WIDTH, WIDTH)

  -- left border
  love.graphics.setColor(colors.SquareColors.BORDER_SIDE)
  love.graphics.polygon(
    "fill",
    x,
    y,
    --
    x + BORDER_WIDTH,
    y + BORDER_WIDTH,
    --
    x + BORDER_WIDTH,
    y + WIDTH - BORDER_WIDTH,
    --
    x,
    y + WIDTH
  )

  -- right border
  love.graphics.setColor(colors.SquareColors.BORDER_SIDE)
  love.graphics.polygon(
    "fill",
    x + WIDTH,
    y,
    --
    x
      + WIDTH
      - BORDER_WIDTH,
    y + BORDER_WIDTH,
    --
    x
      + WIDTH
      - BORDER_WIDTH,
    y + WIDTH - BORDER_WIDTH,
    --
    x + WIDTH,
    y + WIDTH
  )

  -- top border
  love.graphics.setColor(colors.SquareColors.BORDER_TOP)
  love.graphics.polygon(
    "fill",
    x,
    y,
    --
    x + BORDER_WIDTH,
    y + BORDER_WIDTH,
    --
    x
      + WIDTH
      - BORDER_WIDTH,
    y + BORDER_WIDTH,
    --
    x + WIDTH,
    y
  )

  -- bottom border
  love.graphics.setColor(colors.SquareColors.BORDER_BOTTOM)
  love.graphics.polygon(
    "fill",
    x,
    y + WIDTH,
    --
    x + BORDER_WIDTH,
    y + WIDTH - BORDER_WIDTH,
    --
    x
      + WIDTH
      - BORDER_WIDTH,
    y + WIDTH - BORDER_WIDTH,
    --
    x + WIDTH,
    y + WIDTH
  )
end

function Square:copy()
  return Square:new(self.row, self.column, self.color)
end

return Square
