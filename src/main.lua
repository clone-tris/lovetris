require("utils")
local Game = require("screens.game")

local game = Game:new()

function love.draw()
  game:paint()
end
