require("utils")

local Menu = require("screens.menu")
local Game = require("screens.game")

local currentScreen

function love.load()
  love.keyboard.setKeyRepeat(true)
  currentScreen = Menu:new()
end

function love.draw()
  currentScreen:paint()
end

function love.update()
  currentScreen:update()
end

function love.keypressed(key)
  currentScreen:keypressed(key)
end

function love.mousereleased(x, y, button)
  currentScreen:mousereleased(x, y, button)
end

---@param name Screen
---@diagnostic disable-next-line: undefined-field
function love.handlers.useScreen(name)
  if name == "Game" then
    currentScreen = Game:new()
  elseif name == "Menu" then
    currentScreen = Menu:new()
  end
end
