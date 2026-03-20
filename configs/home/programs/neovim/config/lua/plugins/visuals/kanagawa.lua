return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function(_, opts)
    require('kanagawa').setup(opts)
    vim.cmd.colorscheme('kanagawa')
  end,
  opts = {
    colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
    overrides = function(colors)
      local theme = colors.theme
      local c = require('kanagawa.lib.color')

      local blend = function(color, ratio)
        return {
          fg = color,
          bg = c(color):blend(theme.ui.bg, ratio or 0.95):to_hex(),
        }
      end

      return {
        -- Custom window separator line
        WinSeparator = { link = 'FloatBorder' },

        -- Dark completion background
        Pmenu = {
          fg = theme.ui.shade0,
          bg = theme.ui.bg,
          blend = vim.o.pumblend,
        },
        PmenuExtra = { fg = theme.syn.comment, bg = theme.ui.bg },
        PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        -- Transparent floating windows
        NormalFloat = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        FloatTitle = { bg = 'none' },

        -- Tint background of diagnostic messages with their foreground color
        DiagnosticVirtualTextHint = blend(theme.diag.hint),
        DiagnosticVirtualTextInfo = blend(theme.diag.info),
        DiagnosticVirtualTextWarn = blend(theme.diag.warning),
        DiagnosticVirtualTextError = blend(theme.diag.error),
      }
    end,
  },
}
