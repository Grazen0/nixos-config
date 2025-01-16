require('kanagawa').setup({
  transparent = true,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    local palette = colors.palette

    return {
      -- Transparent floating windows
      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      FloatTitle = { bg = 'none' },

      -- Dark completion background
      Pmenu = {
        fg = theme.ui.shade0,
        bg = theme.ui.bg_p1,
        blend = vim.o.pumblend,
      },
      PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      -- bufferline.nvim fixes
      BufferLineFill = { bg = theme.ui.bg_m1 },
      BufferLineSeparator = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      BufferLineSeparatorSelected = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      BufferLineSeparatorVisible = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },

      -- fzf-lua border
      FzfLuaborder = { link = 'FloatBorder' },

      -- markview.nvim custom callouts
      MarkviewBlockQuoteDefinition = { fg = palette.carpYellow },
      MarkviewBlockQuoteTheorem = { fg = palette.oniViolet },
      MarkviewBlockQuoteProperty = { fg = palette.springGreen },
      MarkviewBlockQuoteProof = { fg = palette.springBlue },
      MarkviewBlockQuoteExercise = { fg = palette.surimiOrange },
    }
  end,
})

vim.cmd('colorscheme kanagawa')
