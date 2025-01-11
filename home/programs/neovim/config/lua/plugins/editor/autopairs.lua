local npairs = require('nvim-autopairs')
npairs.setup()

local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
-- a**

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
  Rule('~~', '~~', { 'markdown', 'vimwiki', 'quarto' })
    :with_move(cond.not_before_text('~'))
    :with_pair(cond.not_before_regex('%a+:?:?$', 3)),
  Rule('==', '==', { 'markdown', 'vimwiki', 'quarto' })
    :with_move(cond.not_before_text('~'))
    :with_pair(cond.not_before_regex('%a+:?:?$', 3)),

  -- Generics
  Rule('<', '>', {
    '-html',
    '-javascriptreact',
    '-typescriptreact',
  }):with_pair(cond.before_regex('%a+:?:?$', 3)):with_move(function(opts)
    return opts.char == '>'
  end),
})

table.insert(npairs.get_rule('```').filetypes, 'quarto')

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
