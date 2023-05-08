---@class Screen
local Screen = {}
Screen.__index = Screen

function Screen:new()
  return setmetatable({}, self)
end

function Screen:paint() end
function Screen:update() end

return Screen
