require("utils")
local Game = require("screens.menu")

local game

function love.load()
  love.keyboard.setKeyRepeat(true)
  game = Game:new()
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

function love.mousereleased(x, y, button)
  game:mousereleased(x, y, button)
end
