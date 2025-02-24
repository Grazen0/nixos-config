local function custom_callout(name, icon)
  local capitalized_name = name:sub(1, 1):upper() .. name:sub(2)

  return {
    match_string = name:upper(),
    hl = 'MarkviewBlockQuote' .. capitalized_name,
    preview = icon .. ' ' .. capitalized_name,
    border = '▋',
  }
end

return {
  'OXY2DEV/markview.nvim',
  ft = { 'markdown', 'vimwiki', 'quarto' },
  opts = {
    preview = {
      hybrid_modes = { 'n' },
    },

    markdown = {
      block_quotes = {
        ['DEFINITION'] = custom_callout('definition', ''),
        ['THEOREM'] = custom_callout('theorem', ''),
        ['LEMMA'] = custom_callout('lemma', ''),
        ['COROLLARY'] = custom_callout('corollary', ''),
        ['PROPERTY'] = custom_callout('property', ''),
        ['OBSERVATION'] = custom_callout('observation', ''),
        ['PROOF'] = custom_callout('proof', ''),
        ['EXERCISE'] = custom_callout('exercise', ''),
      },
    },
  },
}
