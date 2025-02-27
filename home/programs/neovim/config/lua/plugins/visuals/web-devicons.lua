return {
  'nvim-tree/nvim-web-devicons',
  lazy = false,
  priority = 1000,
  opts = {
    override_by_extension = {
      ['asm'] = {
        icon = '',
        color = '#ff9e3b',
        name = 'Asm',
      },
      ['s'] = {
        icon = '',
        color = '#ff9e3b',
        name = 'Asm',
      },
      ['inc'] = {
        icon = '',
        color = '#969696',
        name = 'Inc',
      },
      ['envrc'] = {
        icon = '',
        color = '#c8c093',
        name = 'Envrc',
      },
      ['qmd'] = {
        icon = '',
        color = '#7e9cd8',
        name = 'Quarto',
      },
    },
  },
}
