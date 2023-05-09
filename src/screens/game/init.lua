local Sidebar = require("screens.game.sidebar")
local Playfield = require("screens.game.playfield")
local conf = require("conf")

local M = {}

local playfield = Playfield:new(conf.WAR_ZONE_WIDTH, conf.CANVAS_HEIGHT)
local sidebar = Sidebar:new(conf.SIDEBAR_WIDTH, conf.CANVAS_HEIGHT)

M.paint = function()
  sidebar:paint()
  playfield:paint()
end

return M
