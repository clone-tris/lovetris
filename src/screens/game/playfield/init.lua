local M = {}

local painter = require("screens.game.playfield.painter")

M.paint = function()
  painter.draw_background()
end

return M
