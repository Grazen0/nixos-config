local function package_name()
  if vim.fn.search('^package\\s', 'nw') ~= 0 then
    return
  end

  local path = vim.fn.expand('%:p:h')
  local src_index = path:find('/src/')

  if not src_index then
    return
  end

  local name = path:sub(src_index + 5):gsub('/', '.')
  return { 'package ' .. name .. ';', '', '' }
end

local function struct_name(_, snip)
  local filename = snip.env.TM_FILENAME
  return { filename:match('(.+)%..+') }
end

local function struct_snippet(struct_type)
  return s({
    trig = '^' .. struct_type,
    trigEngine = 'pattern',
    hidden = true,
  }, {
    f(package_name),
    t({ 'public ' .. struct_type .. ' ' }),
    f(struct_name),
    t({ ' {' }),
    t({ '', '\t' }),
    i(0),
    t({ '', '}' }),
  })
end

return {
  struct_snippet('class'),
  struct_snippet('enum'),
  struct_snippet('interface'),
}
