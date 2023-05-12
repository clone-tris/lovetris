---@class Score
---@field linesCleared number
---@field total number
---@field level number
local Score = {}
Score.__index = Score

---@return Score
function Score:new()
  local o = { level = 1, total = 0, linesCleared = 0 }
  setmetatable(o, self)
  return o
end
