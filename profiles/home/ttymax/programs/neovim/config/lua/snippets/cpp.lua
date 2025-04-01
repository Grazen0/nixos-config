local function guard_constant()
  local path = vim.fn.expand('%:.:h')
  local src_index = path:find('/src/')

  if src_index then
    path = path:sub(src_index + 5)
  end

  local rel_path = path:upper():gsub('[/%.]', '_')
  return sn(nil, { t(rel_path) })
end

return {
  s({
    trig = '^guard',
    trigEngine = 'pattern',
  }, {
    t({ '#ifndef ' }),
    d(1, guard_constant, {}),
    t({ '', '#define ' }),
    d(1, guard_constant, {}),
    t({ '' }),
    t({ '', i(0) }),
    t({ '' }),
    t({ '', '#endif' }),
  }),
}
