local M = {}

local colors = require("colors")
local rand = require("utils").rand

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

local tetrominoGrids = {
  [Tetromino.T] = { { 0, 0 }, { 0, 1 }, { 0, 2 }, { 1, 1 } },
  [Tetromino.Z] = { { 0, 0 }, { 0, 1 }, { 1, 1 }, { 1, 2 } },
  [Tetromino.S] = { { 0, 1 }, { 0, 2 }, { 1, 0 }, { 1, 1 } },
  [Tetromino.L] = { { 0, 0 }, { 0, 1 }, { 0, 2 }, { 1, 0 } },
  [Tetromino.J] = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 1, 2 } },
  [Tetromino.O] = { { 0, 0 }, { 0, 1 }, { 1, 0 }, { 1, 1 } },
  [Tetromino.I] = { { 0, 0 }, { 0, 1 }, { 0, 2 }, { 0, 3 } },
}

local tetromominoColors = {
  [Tetromino.T] = colors.TetrominoColors.Purple,
  [Tetromino.Z] = colors.TetrominoColors.Red,
  [Tetromino.S] = colors.TetrominoColors.Green,
  [Tetromino.L] = colors.TetrominoColors.Orange,
  [Tetromino.J] = colors.TetrominoColors.Blue,
  [Tetromino.O] = colors.TetrominoColors.Yellow,
  [Tetromino.I] = colors.TetrominoColors.Cyan,
}

M.randomTetromino = function()
  return math.random(10)
end

return M
