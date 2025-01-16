require('markview').setup({
  hybrid_modes = { 'n' },

  block_quotes = {
    callouts = {
      {
        match_string = 'DEFINITION',
        hl = 'MarkviewBlockQuoteDefinition',
        preview = ' Definition',
        icon = ' ',
        border = '▋',
      },
      {
        match_string = 'THEOREM',
        hl = 'MarkviewBlockQuoteTheorem',
        preview = ' Theorem',
        icon = ' ',
        border = '▋',
      },
      {
        match_string = 'PROPERTY',
        hl = 'MarkviewBlockQuoteProperty',
        preview = ' Property',
        icon = ' ',
        border = '▋',
      },
      {
        match_string = 'PROOF',
        hl = 'MarkviewBlockQuoteProof',
        preview = ' Proof',
        icon = ' ',
        border = '▋',
      },
      {
        match_string = 'EXERCISE',
        hl = 'MarkviewBlockQuoteExercise',
        preview = ' Exercise',
        icon = ' ',
        border = '▋',
      },
    },
  },
})
