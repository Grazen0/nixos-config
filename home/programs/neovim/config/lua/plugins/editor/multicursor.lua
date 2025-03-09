return {
  'jake-stewart/multicursor.nvim',
  lazy = true,
  keys = {
    -- Add or skip cursor above/below the main cursor.
    {
      mode = { 'n', 'x' },
      '<Up>',
      function()
        require('multicursor-nvim').lineAddCursor(-1)
      end,
    },
    {
      mode = { 'n', 'x' },
      '<Down>',
      function()
        require('multicursor-nvim').lineAddCursor(1)
      end,
    },
    {
      mode = { 'n', 'x' },
      '<leader><Up>',
      function()
        require('multicursor-nvim').lineSkipCursor(-1)
      end,
    },
    {
      mode = { 'n', 'x' },
      '<leader><Down>',
      function()
        require('multicursor-nvim').lineSkipCursor(1)
      end,
    },

    -- Add or skip adding a new cursor by matching word/selection
    {
      mode = { 'n', 'x' },
      '<leader>n',
      function()
        require('multicursor-nvim').matchAddCursor(1)
      end,
    },
    {
      mode = { 'n', 'x' },
      '<leader>s',
      function()
        require('multicursor-nvim').matchSkipCursor(1)
      end,
    },
    {
      mode = { 'n', 'x' },
      '<leader>N',
      function()
        require('multicursor-nvim').matchAddCursor(-1)
      end,
    },
    {
      mode = { 'n', 'x' },
      '<leader>S',
      function()
        require('multicursor-nvim').matchSkipCursor(-1)
      end,
    },

    -- In normal/visual mode, press `mwap` will create a cursor in every match of
    -- the word captured by `iw` (or visually selected range) inside the bigger
    -- range specified by `ap`. Useful to replace a word inside a function, e.g. mwif.
    {
      mode = { 'n', 'x' },
      'mw',
      function()
        require('multicursor-nvim').operator({ motion = 'iw', visual = true })
      end,
    },

    -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
    { mode = 'n', 'mW', require('multicursor-nvim').operator },

    -- Add all matches in the document
    {
      mode = { 'n', 'x' },
      '<leader>A',
      require('multicursor-nvim').matchAllAddCursors,
    },

    -- Rotate the main cursor.
    { mode = { 'n', 'x' }, '<left>', require('multicursor-nvim').nextCursor },
    { mode = { 'n', 'x' }, '<right>', require('multicursor-nvim').prevCursor },

    -- Delete the main cursor.
    -- set({ 'n', 'x' }, '<leader>x', require('multicursor-nvim').deleteCursor)

    -- Add and remove cursors with control + left click.
    { mode = 'n', '<c-leftmouse>', require('multicursor-nvim').handleMouse },

    { mode = 'n', '<c-leftdrag>', require('multicursor-nvim').handleMouseDrag },
    {
      mode = 'n',
      '<c-leftrelease>',
      require('multicursor-nvim').handleMouseRelease,
    },

    -- Easy way to add and remove cursors using the main cursor.
    { mode = { 'n', 'x' }, '<c-q>', require('multicursor-nvim').toggleCursor },

    -- Clone every cursor and disable the originals.
    {
      mode = { 'n', 'x' },
      '<leader><c-q>',
      require('multicursor-nvim').duplicateCursors,
    },

    {
      mode = 'n',
      '<Esc>',
      function()
        if not require('multicursor-nvim').cursorsEnabled() then
          require('multicursor-nvim').enableCursors()
        elseif require('multicursor-nvim').hasCursors() then
          require('multicursor-nvim').clearCursors()
        else
          -- Default <esc> handler.
          vim.cmd('nohl')
        end
      end,
    },

    -- bring back cursors if you accidentally clear them
    { mode = 'n', '<leader>gv', require('multicursor-nvim').restoreCursors },

    -- Align cursor columns.
    { mode = 'n', '<leader>a', require('multicursor-nvim').alignCursors },

    -- Split visual selections by regex.
    -- set('x', 'S', require('multicursor-nvim').splitCursors)

    -- Append/insert for each line of visual selections.
    { mode = 'x', 'I', require('multicursor-nvim').insertVisual },
    { mode = 'x', 'A', require('multicursor-nvim').appendVisual },

    -- match new cursors within visual selections by regex.
    { mode = 'x', 'M', require('multicursor-nvim').matchCursors },

    -- Rotate visual selection contents.
    {
      mode = 'x',
      '<leader>t',
      function()
        require('multicursor-nvim').transposeCursors(1)
      end,
    },
    {
      mode = 'x',
      '<leader>T',
      function()
        require('multicursor-nvim').transposeCursors(-1)
      end,
    },

    -- Jumplist support
    { mode = { 'x', 'n' }, '<C-i>', require('multicursor-nvim').jumpForward },
    { mode = { 'x', 'n' }, '<C-o>', require('multicursor-nvim').jumpBackward },
  },
  config = function(_, opts)
    require('multicursor-nvim').setup(opts)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { link = 'Cursor' })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
    hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
