--- @diagnostic disable: undefined-global

local function guard_name()
  local path = vim.fn.expand('%:.')
  local src_index = path:find('src/')

  if src_index then
    path = path:sub(src_index + 4)
  end

  local name = path:upper():gsub('[/%.]', '_')
  return sn(nil, { i(1, name) })
end

return {
  s({
    trig = '^guard',
    trigEngine = 'pattern',
    hidden = true,
  }, {
    t({ '#ifndef ' }),
    d(1, guard_name, {}),
    t({ '', '#define ' }),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t({ '', '' }),
    t({ '', '' }),
    i(0),
    t({ '', '' }),
    t({ '', '#endif' }),
  }),
}
