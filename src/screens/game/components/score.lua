---@class Score
---@field linesCleared number
---@field total number
---@field level number
local Score = {}

---@return Score
function Score:new()
  local o = { level = 1, total = 0, linesCleared = 0 }
  setmetatable(o, self)
  self.__index = self

  return o
end

Score.pointsTable = {
  [1] = 40,
  [2] = 100,
  [3] = 300,
  [4] = 1200,
}

return Score
