local Game = require("screens.game")
local colors = require("colors")

local game = Game:new()

function love.draw()
  game:paint()
end
