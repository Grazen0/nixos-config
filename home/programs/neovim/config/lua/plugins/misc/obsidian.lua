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
    ['<localleader>ch'] = {
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
    ['<localleader>on'] = { action = '<cmd>ObsidianNew<CR>' },
    ['<localleader>oo'] = { action = '<cmd>ObsidianOpen<CR>' },
    ['<localleader>of'] = { action = '<cmd>ObsidianQuickSwitch<CR>' },
    ['<localleader>og'] = { action = '<cmd>ObsidianSearch<CR>' },
    ['<localleader>or'] = {
      action = '<cmd>ObsidianRename<CR>',
      opts = { buffer = true },
    },
    -- TODO: dynamically find nearest resources directory
    ['<localleader>op'] = {
      action = '<cmd>ObsidianPasteImg<CR>',
      opts = { buffer = true },
    },
  },
  ui = { enable = false },
  disable_frontmatter = true,
  picker = { name = 'fzf-lua' },
  attachments = {
    img_folder = '',
  },
  follow_url_func = function(url)
    vim.fn.jobstart({ 'xdg-open', url })
  end,
  follow_img_func = function(img)
    vim.fn.jobstart({ 'xdg-open', img })
  end,
})

require('obsidian-bridge').setup({ scroll_sync = true })

vim.api.nvim_create_autocmd(
  { 'InsertLeave', 'TextChanged', 'TextChangedI', 'TextChangedP' },
  {
    pattern = '*.md',
    callback = function(args)
      local buf = args.buf

      if
        vim.fn.getbufvar(buf, '&modifiable') == 1
        and vim.fn.getbufvar(buf, '&filetype') == 'markdown'
        and obsidian.get_client():current_note() ~= nil
      then
        vim.api.nvim_buf_call(buf, function()
          local tmp_autoformat = vim.b.disable_autoformat
          vim.b[buf].disable_autoformat = true

          vim.cmd('silent write')

          vim.b[buf].disable_autoformat = tmp_autoformat
        end)
      end
    end,
  }
)
