local colors = require("colors")
local Square = require("screens.game.components.square")

local M = {}

local graphicGrid = {
  { 1, 2 },
  { 2, 2 },
  { 3, 2 },
  { 3, 3 },
  { 3, 5 },
  { 3, 6 },
  { 3, 7 },
  { 2, 7 },
  { 1, 7 },
  { 1, 6 },
  { 1, 5 },
  { 2, 5 },
  { 2, 9 },
  { 1, 10 },
  { 3, 10 },
  { 3, 11 },
  { 2, 11 },
  { 5, 4 },
  { 6, 4 },
  { 6, 3 },
  { 7, 4 },
  { 8, 3 },
  { 7, 2 },
  { 5, 6 },
  { 7, 6 },
  { 8, 6 },
  { 8, 8 },
  { 7, 8 },
  { 6, 8 },
  { 6, 9 },
  { 6, 10 },
  { 7, 10 },
  { 8, 10 },
  { 10, 3 },
  { 11, 2 },
  { 12, 3 },
  { 11, 4 },
  { 12, 4 },
  { 13, 4 },
  { 14, 3 },
  { 14, 6 },
  { 14, 7 },
  { 14, 8 },
}

M.getGraphicSquareGrid = function()
  local squares = {}
  for _, cell in ipairs(graphicGrid) do
    table.insert(squares, Square:new(cell[1], cell[2], colors.SquareColors.DEFAULT_SQUARE_COLOR))
  end
  return squares
end

return M
