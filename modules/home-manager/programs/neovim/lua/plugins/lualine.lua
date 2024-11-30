require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'filetype', icon_only = true },
      {
        'filename',
        symbols = { modified = ' ', readonly = ' ' },
      },
    },
    lualine_c = {},
    lualine_x = {
      {
        function()
          return ' ' .. require('dap').status()
        end,
        cond = function()
          return package.loaded['dap'] and require('dap').status() ~= ''
        end,
        color = 'Debug',
      },
      {
        'diagnostics',
        sources = {
          'nvim_lsp',
          'nvim_diagnostic',
          'nvim_diagnostic',
          'vim_lsp',
        },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' ',
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
        diagnostics_color = {
          color_error = { fg = 'red' },
          color_warn = { fg = 'yellow' },
          color_info = { fg = 'cyan' },
        },
      },
      {
        function()
          local clients = vim.lsp.get_clients()

          if next(clients) == nil then
            return 'No LSP'
          end

          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, vim.bo.filetype) ~= -1 then
              return client.name
            end
          end

          return 'No LSP'
        end,
        cond = function()
          return vim.fn.index(
            { 'toggleterm', 'NvimTree', 'TelescopePrompt' },
            vim.bo.filetype
          ) == -1
        end,
        icon = ' ',
      },
    },
    lualine_y = {
      { 'searchcount', maxcount = 999, timeout = 120 },
      { 'branch', icon = ' •' },
    },
    lualine_z = {
      'progress',
      'location',
      {
        'fileformat',
        color = { fg = 'black' },
        symbols = {
          unix = '',
          dos = '',
          mac = '',
        },
      },
    },
  },
})
