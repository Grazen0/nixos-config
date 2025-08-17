--- @diagnostic disable: undefined-global

return {
  s('if', {
    t({ '{#if ' }),
    i(1),
    t({ '}' }),
    t({ '', '\t' }),
    i(0),
    t({ '', '{/if}' }),
  }),
  s('elseif', {
    t({ '{:else if ' }),
    i(1),
    t({ '}' }),
    t({ '', '\t' }),
    i(0),
  }),
  s('else', {
    t({ '{:else}' }),
    t({ '', '\t' }),
    i(0),
  }),
  s('each', {
    t({ '{#each ' }),
    i(1),
    t({ ' as ' }),
    i(2),
    t({ '}' }),
    t({ '', '\t' }),
    i(0),
    t({ '', '{/each}' }),
  }),

  s('await', {
    t({ '{#await ' }),
    i(1),
    t({ '}' }),
    t({ '', '\t' }),
    i(2),
    t({ '', '{:then ' }),
    i(3, 'value'),
    t({ '}' }),
    t({ '', '\t' }),
    i(4),
    t({ '', '{:catch ' }),
    i(5, 'err'),
    t({ '}' }),
    t({ '', '\t' }),
    i(6, 'err'),
    t({ '', '{/await}' }),
  }),
}
