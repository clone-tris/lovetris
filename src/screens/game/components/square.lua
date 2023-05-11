local conf = require("conf")

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
  local o = { row = row, column = column, color = color }
  setmetatable(o, self)
  return o
end

---@param refRow number
---@param refColumn number
function Square:draw(refRow, refColumn)
  local x = (refColumn + self.column) * conf.SQUARE_WIDTH
  local y = (refRow + self.row) * conf.SQUARE_WIDTH

  -- background
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", x, y, conf.SQUARE_WIDTH, conf.SQUARE_WIDTH)
end

return Square
