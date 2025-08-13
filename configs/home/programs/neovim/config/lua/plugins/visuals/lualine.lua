return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        { 'filetype', icon_only = true },
        {
          'filename',
          path = 1,
          symbols = { modified = ' ', readonly = ' ' },
        },
      },
      lualine_c = {},
      lualine_x = {
        'diagnostics',
        'lsp_status',
      },
      lualine_y = {
        { 'searchcount', maxcount = 999, timeout = 120 },
        { 'branch', icon = '' },
      },
      lualine_z = { 'progress', 'location', 'fileformat' },
    },
  },
}
