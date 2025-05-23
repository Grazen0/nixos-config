local function opener(fileOrUrl)
  vim.fn.jobstart({ 'xdg-open', fileOrUrl })
end

local function note_id_func(title)
  local suffix = ''

  if title ~= nil then
    suffix = require('lib.string')
      .normalize_accents(title)
      :gsub(' ', '-')
      :gsub('[^A-Za-z0-9-]', '')
      :lower()
  else
    for _ = 1, 4 do
      suffix = suffix .. string.char(math.random(65, 90))
    end
  end

  return tostring(os.time()) .. '-' .. suffix
end

local function note_frontmatter_func(note)
  -- Add the title of the note as an alias.
  if note.title then
    note:add_alias(note.title)
  end

  local out = {
    id = note.id,
    aliases = note.aliases,
    tags = note.tags,
  }

  -- `note.metadata` contains any manually added fields in the frontmatter.
  -- So here we just make sure those fields are kept in the frontmatter.
  if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    for k, v in pairs(note.metadata) do
      out[k] = v
    end
  end

  if out.createdAt == nil and note.id ~= nil then
    if not vim.tbl_contains(out.tags, 'daily') then
      -- Set `createdAt` from note ID timestamp
      local numeric_part = note.id:gmatch('%d+')() or nil
      local timestamp = tonumber(numeric_part)

      if timestamp then
        out.createdAt = os.date('%Y-%m-%d %H:%M', timestamp)
      end
    else
      -- Set `createdAt` from note ID as an actual date
      out.createdAt = note.id .. ' 12:00'
    end
  end

  return out
end

return {
  {
    'oflisback/obsidian-bridge.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    opts = { scroll_sync = true },
    keys = {
      { '<localleader>oc', '<cmd>ObsidianBridgePickCommand<CR>' },
    },
  },
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    event = {
      'BufReadPre ' .. vim.fn.expand('~') .. '/Documents/class-notes/*.md',
      'BufNewFile ' .. vim.fn.expand('~') .. '/Documents/class-notes/*.md',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'oflisback/obsidian-bridge.nvim',
    },
    opts = {
      completion = {
        nvim_cmp = false,
        blink = true,
      },

      workspaces = {
        {
          name = 'class-notes',
          path = '~/Documents/class-notes',
        },
      },

      mappings = {
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ['<localleader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ['<localleader>oo'] = { action = '<cmd>ObsidianOpen<CR>' },
        ['<localleader>or'] = {
          action = '<cmd>ObsidianRename<CR>',
          opts = { buffer = true },
        },
        ['<localleader>op'] = {
          action = '<cmd>ObsidianPasteImg<CR>',
          opts = { buffer = true },
        },
      },

      picker = { name = 'snacks.pick' },
      ui = { enable = false },

      new_notes_location = 'notes_subdir',
      notes_subdir = 'notes',

      attachments = { img_folder = 'attachments' },

      templates = {
        folder = 'vault/templates',
        substitutions = {
          date_text = function()
            return '%B %-d, %Y'
          end,
        },
      },

      daily_notes = {
        folder = 'dailies',
        alias_format = '%B %-d, %Y',
        default_tags = { 'daily' },
        template = 'vault/templates/daily.md',
      },

      follow_url_func = opener,
      follow_img_func = opener,

      note_id_func = note_id_func,
      note_frontmatter_func = note_frontmatter_func,

      callbacks = {
        post_set_workspace = function()
          local keyset = vim.keymap.set

          keyset('n', '<localleader>on', '<cmd>ObsidianNew<CR>')
          keyset('n', '<localleader>of', '<cmd>ObsidianQuickSwitch<CR>')
          keyset('n', '<localleader>og', '<cmd>ObsidianSearch<CR>')
          keyset('n', '<localleader>ot', '<cmd>ObsidianTags<CR>')
          keyset('n', '<localleader>od', '<cmd>ObsidianDailies<CR>')
        end,
      },
    },
  },
}
