require("utils")

local Menu = require("screens.menu")
local Game = require("screens.game")
local Over = require("screens.over")

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
function love.handlers.useScreen(name, a, b, c, d, e, f)
  if name == "Game" then
    currentScreen = Game:new()
  elseif name == "Menu" then
    currentScreen = Menu:new()
  elseif name == "Over" then
    currentScreen = Over:new(a)
  end
end
