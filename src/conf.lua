local M = {}

love.filesystem.setRequirePath("../vendor;" .. love.filesystem.getRequirePath())

M.SQUARE_WIDTH = 24
M.SQUARE_BORDER_WIDTH = 3
M.PUZZLE_HEIGHT = 20
M.PUZZLE_WIDTH = 10

M.SIDEBAR_WIDTH = M.SQUARE_WIDTH * 6
M.WAR_ZONE_WIDTH = M.PUZZLE_WIDTH * M.SQUARE_WIDTH

-- Windows constants
M.CANVAS_WIDTH = M.SIDEBAR_WIDTH + M.WAR_ZONE_WIDTH
M.CANVAS_HEIGHT = M.PUZZLE_HEIGHT * M.SQUARE_WIDTH

function love.conf(t)
  t.window.width = M.CANVAS_WIDTH
  t.window.height = M.CANVAS_HEIGHT
  t.window.x = 5
  t.window.y = 40
  t.window.title = "Lövetris"
end

return M
