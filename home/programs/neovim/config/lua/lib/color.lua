local M = {}

M.rgb_to_hex = function(r, g, b)
  return string.format('#%02x%02x%02x', r, g, b)
end

M.hex_to_rgb = function(hex)
  return tonumber(hex:sub(2, 3), 16),
    tonumber(hex:sub(4, 5), 16),
    tonumber(hex:sub(6, 7), 16)
end

M.blend_colors = function(color1, color2, ratio)
  local r1, g1, b1 = M.hex_to_rgb(color1)
  local r2, g2, b2 = M.hex_to_rgb(color2)

  local r = math.floor(r1 + (r2 - r1) * ratio)
  local g = math.floor(g1 + (g2 - g1) * ratio)
  local b = math.floor(b1 + (b2 - b1) * ratio)

  return M.rgb_to_hex(r, g, b)
end

return M
