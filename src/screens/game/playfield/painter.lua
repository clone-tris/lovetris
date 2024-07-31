local EnginePainter = require("engine.painter")
local conf = require("conf")
local colors = require("colors")

---@class PlayfieldPainter: EnginePainter
---@field width number
---@field height number
local Painter = setmetatable({}, { __index = EnginePainter })

---@param width number
---@param height number
function Painter:new(width, height)
  local o = EnginePainter:new(width, height)
  setmetatable(o, self)
  self.__index = self

  o.width = width
  o.height = height

  return o
end

function Painter:drawBackground()
  love.graphics.clear(colors.UiColors.BACKGROUND)
end

return Painter
