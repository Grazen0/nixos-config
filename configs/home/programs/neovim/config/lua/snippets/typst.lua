---@diagnostic disable: undefined-global

return {
  s({ trig = 'mk', snippetType = 'autosnippet', hidden = true },
    fmta('$<>$ ', { i(1) })
  ),
  s({ trig = 'dm', snippetType = 'autosnippet', hidden = true },
    fmta('$ <> $', { i(1) })
  ),
}
