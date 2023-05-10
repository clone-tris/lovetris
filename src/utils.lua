local A1, A2 = 727595, 798405
local D20, D40 = 1048576, 1099511627776
local X1, X2 = 0, 1

local rand = function()
  local U = X2 * A2
  local V = (X1 * A2 + X2 * A1) % D20
  V = (V * D20 + U) % D40
  X1 = math.floor(V / D20)
  X2 = V - X1 * D20
  return V / D40
end

return {
  rand = rand,
}
