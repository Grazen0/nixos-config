---@diagnostic disable: undefined-global

return {
  s({ trig = 'mt', snippetType = 'autosnippet', hidden = true },
    fmta('$<>$ ', { i(1) })
  ),
  s({ trig = 'mmt', snippetType = 'autosnippet', hidden = true },
    fmta('$ <> $', { i(0) })
  ),
}
