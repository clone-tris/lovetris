local EnginePainter = require("engine.painter")
local conf = require("conf")
local colors = require("colors")

---@class SidebarPainter: EnginePainter
local Painter = setmetatable({}, { __index = EnginePainter })
Painter.__index = Painter

---@param width number
---@param height number
function Painter:new(width, height)
  return setmetatable(EnginePainter:new(width, height), Painter)
end

function Painter:draw_background()
  love.graphics.setColor(colors.TetrominoColors.CYAN)
  love.graphics.rectangle(
    "fill",
    0,
    0,
    self.canvas:getWidth(),
    self.canvas:getHeight()
  )
end

return Painter
