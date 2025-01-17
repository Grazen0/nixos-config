require('r').setup({
  objbr_auto_start = true,
  objbr_place = 'console,below',
  objbr_h = 15,
  R_args = { '--quiet', '--no-save' },
  pipe_keymap = '<C-S-m>',
  pipe_version = 'magrittr',
})

local buf_create_user_command = vim.api.nvim_buf_create_user_command
local r_run = require('r.run')
local r_browser = require('r.browser')
local r_quarto = require('r.quarto')

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'r', 'quarto' },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    buf_create_user_command(
      bufnr,
      'RStart',
      function()
        r_run.start_R('R')
      end,
      { desc = 'Start R with default configuration or reopen terminal window' }
    )

    buf_create_user_command(bufnr, 'RCustomStart', function()
      r_run.start_R('custom')
    end, { desc = 'Ask user to enter parameters to start R' })

    buf_create_user_command(bufnr, 'RClose', function()
      r_run.quit_R('nosave')
    end, { desc = "Send to R: quit(save = 'no')" })

    buf_create_user_command(bufnr, 'RSaveClose', function()
      r_run.quit_R('save')
    end, { desc = 'Quit R, saving the workspace' })

    buf_create_user_command(bufnr, 'ROBToggle', function()
      r_browser.start()
    end, { desc = 'Toggle the Object Browser' })

    buf_create_user_command(
      bufnr,
      'ROBOpenLists',
      function()
        r_browser.open_close_lists('O')
      end,
      { desc = 'Open S4 objects, lists and data.frames in the Object Browser' }
    )

    buf_create_user_command(
      bufnr,
      'ROBCloseLists',
      function()
        r_browser.open_close_lists('C')
      end,
      { desc = 'Close S4 objects, lists and data.frames in the Object Browser' }
    )

    buf_create_user_command(bufnr, 'RClearConsole', function()
      r_run.clear_console()
    end, { desc = 'Send to R: <Ctrl-L>' })

    buf_create_user_command(bufnr, 'RQuartoRender', function()
      r_quarto.command('render')
    end, { desc = 'Send to R: quarto::quarto_render()' })

    buf_create_user_command(bufnr, 'RQuartoPreview', function()
      r_quarto.command('preview')
    end, { desc = 'Send to R: quarto::quarto_preview()' })

    buf_create_user_command(bufnr, 'RQuartoStop', function()
      r_quarto.command('stop')
    end, { desc = 'Send to R: quarto::quarto_preview_stop()' })
  end,
})
