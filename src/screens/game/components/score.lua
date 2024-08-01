---@class Score
---@field level number
---@field linesCleared number
---@field total number
---@field levelText love.Text
---@field linesClearedText love.Text
---@field totalText love.Text
local Score = {}

local font = love.graphics.newFont(14)
local levelText = love.graphics.newText(font)
local linesClearedText = love.graphics.newText(font)
local totalText = love.graphics.newText(font)

---@return Score
function Score:new()
  local o = {
    level = 1,
    total = 0,
    linesCleared = 0,
    levelText = levelText,
    linesClearedText = linesClearedText,
    totalText = totalText,
  }
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
