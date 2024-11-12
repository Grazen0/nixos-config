require('mini.sessions').setup({
  hooks = {
    pre = {
      write = function()
        vim.cmd('Neotree close')
      end,
    },
  },
})
