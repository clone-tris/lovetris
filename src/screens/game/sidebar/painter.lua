local EnginePainter = require("engine.painter")
local conf = require("conf")
local colors = require("colors")

---@class SidebarPainter: EnginePainter
local SidebarPainter = setmetatable({}, { __index = EnginePainter })
SidebarPainter.__index = SidebarPainter

---@param width number
---@param height number
function SidebarPainter:new(width, height)
  return setmetatable(EnginePainter:new(width, height), SidebarPainter)
end

function SidebarPainter:draw_background()
  love.graphics.setColor(colors.TetrominoColors.CYAN)
  love.graphics.rectangle(
    "fill",
    0,
    0,
    self.canvas:getWidth(),
    self.canvas:getHeight()
  )
end

return SidebarPainter
