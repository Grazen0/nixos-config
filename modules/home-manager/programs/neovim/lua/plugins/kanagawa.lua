require('kanagawa').setup({
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

    local makeDiagnosticColor = function(color)
      local c = require('kanagawa.lib.color')
      return { fg = color, bg = c(color):blend(theme.ui.bg, 0.96):to_hex() }
    end

    return {
      -- Dark completion background
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      -- Solid telescope style
      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = {
        fg = theme.ui.fg_dim,
        bg = theme.ui.bg_m1,
      },
      TelescopeResultsBorder = {
        fg = theme.ui.bg_m1,
        bg = theme.ui.bg_m1,
      },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = {
        bg = theme.ui.bg_dim,
        fg = theme.ui.bg_dim,
      },

      -- Tint background of diagnostic messages with their foreground color
      DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
      DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
      DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
      DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
    }
  end,
})

-- Have to call this twice for some reason for it to work properly
vim.cmd('colorscheme kanagawa-wave')
vim.cmd('colorscheme kanagawa-wave')
