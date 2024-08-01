local Screen = require("engine.screen")
local Button = require("engine.components.button")
local conf = require("conf")
local colors = require("colors")

local font = love.graphics.newFont(34)
---@diagnostic disable-next-line: param-type-mismatch
local messageText = love.graphics.newText(font, { colors.UiColors.POPUP_TEXT, "Game Over!" })

---@class Over: Screen
---@field gameCapture love.Image
---@field startButton Button
---@field quitButton Button
local Over = setmetatable({}, { __index = Screen })

function Over:new(image)
  local o = Screen:new()

  o.startButton = Button:new("[S]tart", 4 * conf.SQUARE_WIDTH, 17 * conf.SQUARE_WIDTH)
  o.quitButton = Button:new("[Q]uit", 9 * conf.SQUARE_WIDTH, 17 * conf.SQUARE_WIDTH)
  o.gameCapture = image

  setmetatable(o, self)
  self.__index = self
  return o
end

function Over:paint()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.gameCapture)
  self:drawPopup()
  self.startButton:draw()
  self.quitButton:draw()
end

function Over:drawPopup()
  local padding = 20
  local textWidth, textHeight = messageText:getDimensions()
  local boxWidth = padding * 2 + textWidth
  local boxHeight = padding * 2 + textHeight
  local boxX = (conf.CANVAS_WIDTH - boxWidth) / 2
  local boxY = (conf.CANVAS_HEIGHT - boxHeight) / 2.67

  love.graphics.setColor(colors.UiColors.POPUP_BACKGROUND)
  love.graphics.rectangle("fill", boxX, boxY, boxWidth, boxHeight)

  love.graphics.setColor(colors.UiColors.POPUP_TEXT)
  love.graphics.draw(messageText, math.floor(boxX + padding), math.floor(boxY + padding))
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
