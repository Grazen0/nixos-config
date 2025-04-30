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
          symbols = { modified = ' ', readonly = ' ' },
        },
      },
      lualine_c = {},
      lualine_x = {
        'diagnostics',
        {
          function()
            local clients = vim.lsp.get_clients()

            if next(clients) == nil then
              return 'No LSP'
            end

            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if
                filetypes and vim.fn.index(filetypes, vim.bo.filetype) ~= -1
              then
                return client.name
              end
            end

            return 'No LSP'
          end,
          cond = function()
            return vim.fn.index(
              { 'toggleterm', 'snacks_picker_list' },
              vim.bo.filetype
            ) == -1
          end,
          icon = ' ',
        },
      },
      lualine_y = {
        { 'searchcount', maxcount = 999, timeout = 120 },
        { 'branch', icon = '' },
      },
      lualine_z = { 'progress', 'location', 'fileformat' },
    },
  },
}
