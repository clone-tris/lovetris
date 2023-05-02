local sidebar = require "screens.game.sidebar"
local playfield = require "screens.game.playfield"

local M = {}

M.paint = function()
    sidebar.paint()
    playfield.paint()
end

return M
