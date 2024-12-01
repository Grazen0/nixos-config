require('plugins.visuals.kanagawa')
require('plugins.visuals.colorizer')
require('plugins.visuals.gitsigns')
require('plugins.visuals.lualine')
require('plugins.visuals.bufferline')

require('highlight-undo').setup()
require('window-picker').setup()
require('tailwindcss-colors').setup()
require('hmts').setup()

require('ibl').setup({ indent = { char = '│' } })
require('dressing').setup({ input = { default_prompt = 'Rename' } })
