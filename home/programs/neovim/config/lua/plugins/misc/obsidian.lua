local obsidian = require('obsidian')

obsidian.setup({
  workspaces = {
    {
      name = 'class-notes',
      path = '~/Documents/Class Notes',
    },
  },
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ['gf'] = {
      action = function()
        return obsidian.util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ['<leader>ch'] = {
      action = function()
        return obsidian.util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ['<cr>'] = {
      action = function()
        return obsidian.util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
    ['<localleader>oo'] = { action = '<cmd>ObsidianOpen<CR>' },
    ['<localleader>of'] = { action = '<cmd>ObsidianQuickSwitch<CR>' },
    ['<localleader>og'] = { action = '<cmd>ObsidianSearch<CR>' },
    ['<localleader>or'] = { action = '<cmd>ObsidianRename<CR>' },
    ['<localleader>op'] = { action = '<cmd>ObsidianPasteImg<CR>' }, -- TODO: dynamically find nearest resources directory
  },
  ui = { enable = false },
  disable_frontmatter = true,
  picker = { name = 'fzf-lua' },
  attachments = {
    img_folder = '',
  },
  follow_url_func = function(img)
    vim.fn.jobstart({ 'xdg-open', img })
  end,
  follow_img_func = function(img)
    vim.fn.jobstart({ 'xdg-open', img })
  end,
})
