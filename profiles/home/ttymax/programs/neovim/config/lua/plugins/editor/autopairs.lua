return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function(_, opts)
    local npairs = require('nvim-autopairs')
    npairs.setup(opts)

    local Rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')

    npairs.add_rules({
      -- Markdown stuff
      Rule('$', '$', { 'markdown', 'vimwiki', 'quarto' })
        :with_move(cond.not_before_text('$'))
        :with_pair(cond.not_before_regex('%a+:?:?$', 3)),
      Rule('*', '*', { 'markdown', 'vimwiki', 'quarto' })
        :with_move(cond.not_before_text('*'))
        :with_pair(cond.not_before_regex('%a+:?:?$', 3)),
      Rule('_', '_', { 'markdown', 'vimwiki', 'quarto' })
        :with_move(cond.not_before_text('_'))
        :with_pair(cond.not_before_regex('%a+:?:?$', 3)),

      -- Templates/generics
      Rule('<', '>', {
        '-html',
        '-javascriptreact',
        '-typescriptreact',
      }):with_pair(cond.before_regex('%a+:?:?$', 3)):with_move(function(o)
        return o.char == '>'
      end),
    })

    table.insert(npairs.get_rule('```').filetypes, 'quarto')
  end,
}
