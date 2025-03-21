local create_user_command = vim.api.nvim_create_user_command

local function alias_with_bang(cmd)
  return function(args)
    if args.bang then
      vim.cmd(cmd .. '!')
    else
      vim.cmd(cmd)
    end
  end
end

-- I'm kinda clumsy
create_user_command('W', alias_with_bang('w'), { bang = true })
create_user_command('Wa', alias_with_bang('wa'), { bang = true })
create_user_command('X', alias_with_bang('x'), { bang = true })
create_user_command('Xa', alias_with_bang('xa'), { bang = true })
create_user_command('Q', alias_with_bang('q'), { bang = true })
create_user_command('Qa', alias_with_bang('qa'), { bang = true })
create_user_command('Bd', alias_with_bang('bd'), { bang = true })
