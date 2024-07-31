require("utils")
local Menu = require("screens.menu.init")

---@type GameScreen
local game

function love.load()
  love.keyboard.setKeyRepeat(true)
  game = Menu:new()
end

function love.draw()
  game:paint()
end

function love.update()
  game:update()
end

function love.keypressed(key)
  game:keypressed(key)
end
