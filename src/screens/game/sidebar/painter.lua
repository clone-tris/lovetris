local EnginePainter = require("engine.painter")
local conf = require("conf")
local colors = require("colors")

---@class SidebarPainter: EnginePainter
local Painter = setmetatable({}, { __index = EnginePainter })

---@param width number
---@param height number
function Painter:new(width, height)
  local o = EnginePainter:new(width, height)
  setmetatable(o, self)
  self.__index = self

  return o
end

function Painter:drawBackground()
  love.graphics.setColor(colors.UiColors.SIDEBAR_BACKGROUND)
  love.graphics.clear(colors.UiColors.SIDEBAR_BACKGROUND)
end

return Painter
