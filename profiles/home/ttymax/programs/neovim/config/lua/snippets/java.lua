local function struct_name(_, snip)
  local env = snip.env

  if
    vim.fn.search([[^public\s\+\(class\|enum\|interface\)\s\+\w\+]], 'nw') ~= 0
  then
    return sn(nil, { i(1) })
  end

  return sn(nil, { t(env.TM_FILENAME:match('(.+)%..+')) })
end

local function package_name()
  if vim.fn.search('^package\\s', 'nw') ~= 0 then
    return
  end

  local path = vim.fn.expand('%:p:h')
  local src_index = path:find('/src/')

  if not src_index then
    return
  end

  local package_name = path:sub(src_index + 5):gsub('/', '.')
  return { 'package ' .. package_name .. ';', '', '' }
end

return {
  s({
    trig = '^class',
    trigEngine = 'pattern',
    hidden = true,
  }, {
    f(package_name),
    t({ 'public class ' }),
    d(1, struct_name, {}),
    t({ ' {' }),
    t({ '', '\t' }),
    i(0),
    t({ '', '}' }),
  }),
  s({
    trig = '^enum',
    trigEngine = 'pattern',
    hidden = true,
  }, {
    f(package_name),
    t({ 'public enum ' }),
    d(1, struct_name, {}),
    t({ ' {' }),
    t({ '', '\t' }),
    i(0),
    t({ '', '}' }),
  }),
  s({
    trig = '^interface',
    trigEngine = 'pattern',
    hidden = true,
  }, {
    f(package_name),
    t({ 'public interface ' }),
    d(1, struct_name, {}),
    t({ ' {' }),
    t({ '', '\t' }),
    i(0),
    t({ '', '}' }),
  }),
}
