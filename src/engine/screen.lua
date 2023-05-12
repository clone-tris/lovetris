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

return Screen
