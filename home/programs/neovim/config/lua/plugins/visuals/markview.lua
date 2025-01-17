local function custom_callout(name, icon)
  local capitalized_name = name:sub(1, 1):upper() .. name:sub(2)

  return {
    match_string = name:upper(),
    hl = 'MarkviewBlockQuote' .. capitalized_name,
    preview = icon .. ' ' .. capitalized_name,
    icon = icon .. ' ',
    border = '▋',
  }
end

require('markview').setup({
  hybrid_modes = { 'n' },

  block_quotes = {
    callouts = {
      custom_callout('definition', ''),
      custom_callout('theorem', ''),
      custom_callout('lemma', ''),
      custom_callout('corollary', ''),
      custom_callout('property', ''),
      custom_callout('proof', ''),
      custom_callout('exercise', ''),
    },
  },
})
