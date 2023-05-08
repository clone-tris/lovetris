local EnginePainter = require("engine.painter")
local conf = require("conf")
local colors = require("colors")

---@class Painter: EnginePainter
local Painter = setmetatable({}, { __index = EnginePainter })
Painter.__index = Painter

---@param width number
---@param height number
function Painter:new(width, height)
  return setmetatable(EnginePainter:new(width, height), self)
end

function Painter:draw_background()
  love.graphics.setColor(colors.TetrominoColors.RED)
  love.graphics.rectangle(
    "fill",
    conf.SIDEBAR_WIDTH,
    0,
    conf.WAR_ZONE_WIDTH,
    conf.CANVAS_HEIGHT
  )
end

return Painter
