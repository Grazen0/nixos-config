return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function(_, opts)
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        callback = function()
          if vim.tbl_contains(require('nvim-treesitter').get_installed(), vim.bo.filetype) then
            vim.treesitter.start()
          end
        end,
      })
    end,
  },
}
