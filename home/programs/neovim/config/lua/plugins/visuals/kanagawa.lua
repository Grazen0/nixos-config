local lib_color = require('lib.color')

local function markview_heading(theme, fg_color)
  return {
    fg = fg_color,
    bg = lib_color.blend_colors(fg_color, theme.ui.bg, 0.7),
  }
end

return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function(_, opts)
    require('kanagawa').setup(opts)
    vim.cmd('colorscheme kanagawa')
  end,
  opts = {
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
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
        PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        -- dashboard-nvim
        DashboardHeader = { fg = palette.crystalBlue },
        DashboardIcon = { fg = palette.springGreen },

        -- markview.nvim headings and custom callouts
        MarkviewHeading1 = markview_heading(theme, palette.peachRed),
        MarkviewHeading2 = markview_heading(theme, palette.surimiOrange),
        MarkviewHeading3 = markview_heading(theme, palette.carpYellow),
        MarkviewHeading4 = markview_heading(theme, palette.springGreen),
        MarkviewHeading5 = markview_heading(theme, palette.springBlue),
        MarkviewHeading6 = markview_heading(theme, palette.springViolet1),
        MarkviewBlockQuoteDefinition = { fg = palette.carpYellow },
        MarkviewBlockQuoteTheorem = { fg = palette.oniViolet },
        MarkviewBlockQuoteLemma = { fg = palette.springViolet1 },
        MarkviewBlockQuoteCorollary = { fg = palette.springViolet1 },
        MarkviewBlockQuoteProperty = { fg = palette.springGreen },
        MarkviewBlockQuoteObservation = { fg = palette.springGreen },
        MarkviewBlockQuoteProof = { fg = palette.springBlue },
        MarkviewBlockQuoteExercise = { fg = palette.surimiOrange },
      }
    end,
  },
}
