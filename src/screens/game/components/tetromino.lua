local Square = require("screens.game.components.square")
local Shape = require("screens.game.components.shape")

local M = {}

local colors = require("colors")

---@enum Tetromino
local Tetromino = {
  T = "T",
  Z = "Z",
  S = "S",
  L = "L",
  J = "J",
  O = "O",
  I = "I",
}

---@type Tetromino[]
local Names = {}
for k in pairs(Tetromino) do
  table.insert(Names, k)
end

local Grids = {
  [Tetromino.T] = { { 0, 0 }, { 0, 1 }, { 0, 2 }, { 1, 1 } },
  [Tetromino.Z] = { { 0, 0 }, { 0, 1 }, { 1, 1 }, { 1, 2 } },
  [Tetromino.S] = { { 0, 1 }, { 0, 2 }, { 1, 0 }, { 1, 1 } },
  [Tetromino.L] = { { 0, 0 }, { 0, 1 }, { 0, 2 }, { 1, 0 } },
  [Tetromino.J] = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 1, 2 } },
  [Tetromino.O] = { { 0, 0 }, { 0, 1 }, { 1, 0 }, { 1, 1 } },
  [Tetromino.I] = { { 0, 0 }, { 0, 1 }, { 0, 2 }, { 0, 3 } },
}

local Colors = {
  [Tetromino.T] = colors.TetrominoColors.PURPLE,
  [Tetromino.Z] = colors.TetrominoColors.RED,
  [Tetromino.S] = colors.TetrominoColors.GREEN,
  [Tetromino.L] = colors.TetrominoColors.ORANGE,
  [Tetromino.J] = colors.TetrominoColors.BLUE,
  [Tetromino.O] = colors.TetrominoColors.YELLOW,
  [Tetromino.I] = colors.TetrominoColors.CYAN,
}

M.randomTetromino = function()
  local name = Names[math.random(#Names)]
  local grid = Grids[name]
  local color = Colors[name]

  local squares = {}
  for _, cell in ipairs(grid) do
    table.insert(squares, Square:new(cell[1], cell[2], color))
  end

  return Shape:new(0, 0, squares)
end

return M
