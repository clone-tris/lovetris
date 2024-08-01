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
  CYAN = hex2rgba("#00e6fe"),
  BLUE = hex2rgba("#1801ff"),
  ORANGE = hex2rgba("#ff7308"),
  YELLOW = hex2rgba("#ffde00"),
  GREEN = hex2rgba("#66fd00"),
  PURPLE = hex2rgba("#b802fd"),
  RED = hex2rgba("#fe103c"),
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
