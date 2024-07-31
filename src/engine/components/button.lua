local colors = require("colors")

local font = love.graphics.newFont(14)
local BUTTON_PADDING_LEFT = 8
local BUTTON_PADDING_TOP = 8

---@class Button
---@field textElement love.Text
---@field text string
---@field x number
---@field y number
---@field textX number
---@field textY number
---@field width number
---@field height number
---@field textWidth number
---@field textHeight number
local Button = {}

---@param text string
---@param x number
---@param y number
function Button:new(text, x, y)
  local textElement = love.graphics.newText(font)
  textElement:set({ colors.UiColors.BUTTON_TEXT, text })
  local textWidth, textHeight = textElement:getDimensions()

  local width = 2 * BUTTON_PADDING_LEFT + textWidth
  local height = 2 * BUTTON_PADDING_TOP + textHeight

  local textX = x + (width - textWidth) / 2
  local textY = y + (height - textHeight) / 2

  local o = {
    textElement = textElement,
    text = text,
    x = x,
    y = y,
    textX = textX,
    textY = textY,
    width = width,
    height = height,
    textWidth = textWidth,
    textHeight = textHeight,
  }

  setmetatable(o, self)
  self.__index = self

  return o
end

function Button:draw()
  love.graphics.setColor(colors.TetrominoColors.CYAN)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  love.graphics.draw(self.textElement, self.textX, self.textY)
end

---@param x number
---@param y number
---@return boolean
function Button:contains(x, y)
  -- stylua: ignore start
  return x >= self.x
    and x <= (self.x + self.width)
    and y >= self.y
    and y <= (self.y + self.height)
  -- stylua: ignore end
end

return Button
