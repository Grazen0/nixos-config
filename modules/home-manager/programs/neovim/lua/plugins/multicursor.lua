local mc = require('multicursor-nvim')

mc.setup()

local keyset = vim.keymap.set

-- Add or skip cursor above/below the main cursor.
keyset({ 'n', 'v' }, '<Up>', function()
  mc.lineAddCursor(-1)
end)
keyset({ 'n', 'v' }, '<Down>', function()
  mc.lineAddCursor(1)
end)
keyset({ 'n', 'v' }, '<leader><Up>', function()
  mc.lineSkipCursor(-1)
end)
keyset({ 'n', 'v' }, '<leader><Down>', function()
  mc.lineSkipCursor(1)
end)

-- Add or skip adding a new cursor by matching word/selection
-- set({ 'n', 'v' }, '<leader>n', function()
--   mc.matchAddCursor(1)
-- end)
-- set({ 'n', 'v' }, '<leader>s', function()
--   mc.matchSkipCursor(1)
-- end)
-- set({ 'n', 'v' }, '<leader>N', function()
--   mc.matchAddCursor(-1)
-- end)
-- set({ 'n', 'v' }, '<leader>S', function()
--   mc.matchSkipCursor(-1)
-- end)

-- Add all matches in the document
keyset({ 'n', 'v' }, '<leader>A', mc.matchAllAddCursors)

-- Rotate the main cursor.
keyset({ 'n', 'v' }, '<Left>', mc.nextCursor)
keyset({ 'n', 'v' }, '<Right>', mc.prevCursor)

-- Delete the main cursor.
keyset({ 'n', 'v' }, '<leader>x', mc.deleteCursor)

-- Add and remove cursors with control + left click.
keyset('n', '<C-LeftMouse>', mc.handleMouse)

-- Easy way to add and remove cursors using the main cursor.
keyset({ 'n', 'v' }, '<C-q>', mc.toggleCursor)

-- Clone every cursor and disable the originals.
keyset({ 'n', 'v' }, '<leader><C-q>', mc.duplicateCursors)

keyset('n', '<Esc>', function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    vim.cmd('nohl')
  end
end)

-- bring back cursors if you accidentally clear them
keyset('n', '<leader>gv', mc.restoreCursors)

-- Align cursor columns.
keyset('n', '<leader>a', mc.alignCursors)

-- Split visual selections by regex.
-- keyset('v', 'S', mc.splitCursors)

-- Append/insert for each line of visual selections.
keyset('v', 'I', mc.insertVisual)
keyset('v', 'A', mc.appendVisual)

-- match new cursors within visual selections by regex.
keyset('v', 'M', mc.matchCursors)

-- Rotate visual selection contents.
keyset('v', '<leader>t', function()
  mc.transposeCursors(1)
end)
keyset('v', '<leader>T', function()
  mc.transposeCursors(-1)
end)

-- Jumplist support
keyset({ 'v', 'n' }, '<C-i>', mc.jumpForward)
keyset({ 'v', 'n' }, '<C-o>', mc.jumpBackward)

-- Customize how cursors look.
local hl = vim.api.nvim_set_hl
hl(0, 'MultiCursorCursor', { link = 'Cursor' })
hl(0, 'MultiCursorVisual', { link = 'Visual' })
hl(0, 'MultiCursorSign', { link = 'SignColumn' })
hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
