local Screen = require("engine.screen")
local Button = require("engine.components.button")
local conf = require("conf")

---@class Over: Screen
---@field gameCapture love.Image
---@field startButton Button
---@field quitButton Button
local Over = setmetatable({}, { __index = Screen })

function Over:new(image)
  local o = Screen:new()

  o.startButton = Button:new("[S]tart", 4 * conf.SQUARE_WIDTH, 17 * conf.SQUARE_WIDTH)
  o.quitButton = Button:new("[Q]uit", 8 * conf.SQUARE_WIDTH, 17 * conf.SQUARE_WIDTH)
  o.gameCapture = image

  setmetatable(o, self)
  self.__index = self
  return o
end

function Over:paint()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.gameCapture)
  self.startButton:draw()
  self.quitButton:draw()
end

---@param key love.KeyConstant
function Over:keypressed(key)
  if key == "s" then
    ---@diagnostic disable-next-line: param-type-mismatch
    love.event.push("useScreen", "Game")
  end

  if key == "q" then
    love.event.push("quit")
  end
end

---@param x number
---@param y number
---@param button number
function Over:mousereleased(x, y, button)
  if button ~= 1 then
    return
  end
  if self.startButton:contains(x, y) then
    ---@diagnostic disable-next-line: param-type-mismatch
    love.event.push("useScreen", "Game")
  end
  if self.quitButton:contains(x, y) then
    love.event.push("quit")
  end
end

return Over
