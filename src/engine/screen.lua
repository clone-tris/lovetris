---@class Screen
local Screen = {}

function Screen:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Screen:paint() end
function Screen:update() end

---@param key love.KeyConstant
function Screen:keypressed(key) end

---@param x number
---@param y number
---@param button number
function Screen:mousereleased(x, y, button) end

return Screen
