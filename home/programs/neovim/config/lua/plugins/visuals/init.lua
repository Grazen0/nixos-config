require('plugins.visuals.kanagawa')
require('plugins.visuals.colorizer')
require('plugins.visuals.gitsigns')
require('plugins.visuals.lualine')
require('plugins.visuals.markview')
require('plugins.visuals.bufferline')

require('highlight-undo').setup()
require('window-picker').setup()

require('lib.misc').setup_on_ft(
  { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  'tailwindcss-colors'
)
require('tiny-devicons-auto-colors').setup()

require('ibl').setup({ indent = { char = '│' } })
require('dressing').setup({ input = { default_prompt = 'Rename' } })

-- For some reason this has to be called here
-- Custom colors appear as white otherwise
require('plugins.visuals.web-devicons')
