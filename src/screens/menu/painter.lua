local EnginePainter = require("engine.painter")
local colors = require("colors")
local conf = require("conf")

---@class MenuPainter: EnginePainter
local Painter = setmetatable({}, { __index = EnginePainter })

function Painter:new()
  local o = EnginePainter:new(conf.CANVAS_WIDTH, conf.CANVAS_HEIGHT)
  setmetatable(o, self)
  self.__index = self
  return o
end

function Painter:drawBackground()
  love.graphics.clear(colors.UiColors.BACKGROUND)
end

return Painter
