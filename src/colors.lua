---@param hex string
---@return number[]
local function hex2rgba(hex)
  local hasAlpha = string.len(hex) == 9
  return {
    tonumber(string.sub(hex, 2, 3), 16) / 256,
    tonumber(string.sub(hex, 4, 5), 16) / 256,
    tonumber(string.sub(hex, 6, 7), 16) / 256,
    hasAlpha and tonumber(string.sub(hex, 8, 9), 16) / 256 or 1,
  }
end

---@enum TetrominoColors
local TetrominoColors = {
  CYAN = hex2rgba("#6DECEE"),
  BLUE = hex2rgba("#0014E6"),
  ORANGE = hex2rgba("#E4A338"),
  YELLOW = hex2rgba("#F0EF4F"),
  GREEN = hex2rgba("#6EEB47"),
  PURPLE = hex2rgba("#9225E7"),
  RED = hex2rgba("#DC2F20"),
}

---@enum SquareColors
local SquareColors = {
  DEFAULT_SQUARE_COLOR = hex2rgba("#cc8081"),
  BORDER_TOP = hex2rgba("#ffffffb3"),
  BORDER_BOTTOM = hex2rgba("#00000080"),
  BORDER_SIDE = hex2rgba("#0000001a"),
}

---@enum UiColors
local UiColors = {
  BACKGROUND = hex2rgba("#333333"),
  SIDEBAR_BACKGROUND = hex2rgba("#545454"),
  POPUP_BACKGROUND = hex2rgba("#212121"),
  BUTTON_BACKGROUND = TetrominoColors.CYAN,
  GUIDE = hex2rgba("#555555"),
  WHITE_TEXT = hex2rgba("#FFFFFF"),
  POPUP_TEXT = hex2rgba("#EFEFEF"),
  BUTTON_TEXT = hex2rgba("#212121"),
}

---@alias Color UiColors|TetrominoColors|SquareColors

return {
  hex2rgba = hex2rgba,
  TetrominoColors = TetrominoColors,
  UiColors = UiColors,
  SquareColors = SquareColors,
}
