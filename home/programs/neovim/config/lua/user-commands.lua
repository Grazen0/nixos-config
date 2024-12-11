local create_user_command = vim.api.nvim_create_user_command

-- I'm kinda clumsy
create_user_command('W', 'w', {})
create_user_command('Wa', 'wa', {})
create_user_command('X', 'x', {})
create_user_command('Xa', 'xa', {})
create_user_command('Q', 'q', {})
create_user_command('Qa', 'qa', {})

-- Format bufffer
create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line =
      vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format({
    async = true,
    lsp_format = 'fallback',
    range = range,
  })
end, { range = true })

-- Toggle formatting
create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { bang = true })

create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { bang = true })

-- Close all buffers except current
create_user_command('Zen', '%bd|e#|bd#', {})

-- Sessions
create_user_command('SessionWrite', function(opts)
  MiniSessions.write(opts.args)
end, { nargs = 1 })

create_user_command('SessionDelete', function(opts)
  if opts.args == '' then
    MiniSessions.delete(nil, { force = true })
  else
    MiniSessions.delete(opts.args, { force = true })
  end
end, {
  nargs = '?',
  complete = function()
    local sessions = {}
    for session_name, _ in pairs(MiniSessions.detected) do
      table.insert(sessions, session_name)
    end
    return sessions
  end,
})
