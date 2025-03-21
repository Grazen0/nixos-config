return {
  'R-nvim/R.nvim',
  enabled = false,
  lazy = false, -- Otherwise the options won't be loaded for some reason
  -- ft = { 'r', 'quarto' },
  opts = {
    objbr_place = 'console,below',
    objbr_h = 15,
    R_args = { '--quiet', '--no-save' },
    pipe_version = 'magrittr',
    -- Free ,m and ,o
    disable_cmds = { 'RSendMotion', 'RInsertLineOutput' },
    hook = {
      on_filetype = function()
        local r_run = require('r.run')
        local r_browser = require('r.browser')
        local r_quarto = require('r.quarto')

        vim.api.nvim_buf_set_keymap(
          0,
          'i',
          '<C-S-m>',
          '<Plug>RInsertPipe',
          { noremap = true }
        )

        local buf_create_user_command = vim.api.nvim_buf_create_user_command

        buf_create_user_command(0, 'RStart', function()
          r_run.start_R('R')
        end, {
          desc = 'Start R with default configuration or reopen terminal window',
        })

        buf_create_user_command(0, 'RCustomStart', function()
          r_run.start_R('custom')
        end, { desc = 'Ask user to enter parameters to start R' })

        buf_create_user_command(0, 'RClose', function()
          r_run.quit_R('nosave')
        end, { desc = "Send to R: quit(save = 'no')" })

        buf_create_user_command(0, 'RSaveClose', function()
          r_run.quit_R('save')
        end, { desc = 'Quit R, saving the workspace' })

        buf_create_user_command(0, 'ROBToggle', function()
          r_browser.start()
        end, { desc = 'Toggle the Object Browser' })

        buf_create_user_command(0, 'ROBOpenLists', function()
          r_browser.open_close_lists('O')
        end, {
          desc = 'Open S4 objects, lists and data.frames in the Object Browser',
        })

        buf_create_user_command(0, 'ROBCloseLists', function()
          r_browser.open_close_lists('C')
        end, {
          desc = 'Close S4 objects, lists and data.frames in the Object Browser',
        })

        buf_create_user_command(0, 'RClearConsole', function()
          r_run.clear_console()
        end, { desc = 'Send to R: <Ctrl-L>' })

        buf_create_user_command(0, 'RQuartoRender', function()
          r_quarto.command('render')
        end, { desc = 'Send to R: quarto::quarto_render()' })

        buf_create_user_command(0, 'RQuartoPreview', function()
          r_quarto.command('preview')
        end, { desc = 'Send to R: quarto::quarto_preview()' })

        buf_create_user_command(0, 'RQuartoStop', function()
          r_quarto.command('stop')
        end, { desc = 'Send to R: quarto::quarto_preview_stop()' })
      end,
    },
  },
}
