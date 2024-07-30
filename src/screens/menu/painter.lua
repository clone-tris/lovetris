local EnginePainter = require("engine.painter")
local colors = require("colors")

---@class MenuPainter: EnginePainter
local Painter = setmetatable({}, { __index = EnginePainter })

function Painter:new()
  local o = EnginePainter:new()
  setmetatable(o, self)
  self.__index = self
  return o
end

function Painter:drawBackground()
  love.graphics.clear(colors.TetrominoColors.PURPLE)
end

return Painter
