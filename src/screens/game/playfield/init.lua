local conf = require("conf")
local Screen = require("engine.screen")
local Painter = require("screens.game.playfield.painter")

---@class Playfield: Screen
---@field painter Painter
local Playfield = setmetatable({}, { __index = Screen })
Playfield.__index = Playfield

---@param width number
---@param height number
function Playfield:new(width, height)
  local o = setmetatable(Screen:new(), Playfield)
  o.painter = Painter:new(width, height)
  return o
end

function Playfield:paint()
  love.graphics.setCanvas(self.painter.canvas)
  --
  self.painter:draw_background()
  self.painter:draw_guide()
  --
  love.graphics.setCanvas()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.painter.canvas, conf.SIDEBAR_WIDTH, 0)
end

return Playfield
