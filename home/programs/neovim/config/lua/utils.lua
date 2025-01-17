local M = {}

local accents = {}

accents['À'] = 'A'
accents['Á'] = 'A'
accents['Â'] = 'A'
accents['Ã'] = 'A'
accents['Ä'] = 'A'
accents['Å'] = 'A'
accents['Æ'] = 'AE'
accents['Ç'] = 'C'
accents['È'] = 'E'
accents['É'] = 'E'
accents['Ê'] = 'E'
accents['Ë'] = 'E'
accents['Ì'] = 'I'
accents['Í'] = 'I'
accents['Î'] = 'I'
accents['Ï'] = 'I'
accents['Ð'] = 'D'
accents['Ñ'] = 'N'
accents['Ò'] = 'O'
accents['Ó'] = 'O'
accents['Ô'] = 'O'
accents['Õ'] = 'O'
accents['Ö'] = 'O'
accents['Ø'] = 'O'
accents['Ù'] = 'U'
accents['Ú'] = 'U'
accents['Û'] = 'U'
accents['Ü'] = 'U'
accents['Ý'] = 'Y'
accents['Þ'] = 'P'
accents['ß'] = 's'
accents['à'] = 'a'
accents['á'] = 'a'
accents['â'] = 'a'
accents['ã'] = 'a'
accents['ä'] = 'a'
accents['å'] = 'a'
accents['æ'] = 'ae'
accents['ç'] = 'c'
accents['è'] = 'e'
accents['é'] = 'e'
accents['ê'] = 'e'
accents['ë'] = 'e'
accents['ì'] = 'i'
accents['í'] = 'i'
accents['î'] = 'i'
accents['ï'] = 'i'
accents['ð'] = 'eth'
accents['ñ'] = 'n'
accents['ò'] = 'o'
accents['ó'] = 'o'
accents['ô'] = 'o'
accents['õ'] = 'o'
accents['ö'] = 'o'
accents['ø'] = 'o'
accents['ù'] = 'u'
accents['ú'] = 'u'
accents['û'] = 'u'
accents['ü'] = 'u'
accents['ý'] = 'y'
accents['þ'] = 'p'
accents['ÿ'] = 'y'

M.normalize_accents = function(str)
  return str:gsub('[%z\1-\127\194-\244][\128-\191]*', accents)
end

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
