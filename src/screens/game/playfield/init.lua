local Painter = require("screens.game.playfield.painter")
local Screen = require("engine.screen")

---@class Playfield: Screen
---@field painter Painter
local Playfield = setmetatable({}, { __index = Screen })
Playfield.__index = Playfield

---@param width number
---@param height number
function Playfield:new(width, height)
  local meta = setmetatable(Screen:new(), self)
  meta.painter = Painter:new(width, height)
  return meta
end

function Playfield:paint()
  self.painter.draw_background()
end

return Playfield
