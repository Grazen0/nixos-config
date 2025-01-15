require('plugins.visuals.kanagawa')
require('plugins.visuals.colorizer')
require('plugins.visuals.gitsigns')
require('plugins.visuals.lualine')
require('plugins.visuals.bufferline')

require('highlight-undo').setup()
require('window-picker').setup()
require('tailwindcss-colors').setup()
-- require('hmts').setup()
require('tiny-devicons-auto-colors').setup()

require('ibl').setup({ indent = { char = '│' } })
require('dressing').setup({ input = { default_prompt = 'Rename' } })
require('markview').setup({ hybrid_modes = { 'n' } })

-- For some reason this has to be called here
-- Custom colors appear as white otherwise
require('plugins.visuals.web-devicons')
