return {
  s({
    trig = '^!!',
    trigEngine = 'pattern',
    hidden = true,
  }, {
    t({ '> [!' }),
    i(1, 'NOTE'),
    t({ ']' }),
    i(2),
    t({ '', '> ' }),
    i(3),
    t({ '', '' }),
    i(0),
  }),
}
