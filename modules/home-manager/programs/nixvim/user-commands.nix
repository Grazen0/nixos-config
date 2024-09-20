{
  programs.nixvim.userCommands = {
    # I'm clumsy
    W.command = "write";
    Wa.command = "wall";

    ClearBuffers.command = "%bd|e#|bd#"; # Close all buffers except urrent

    Format = {
      command.__raw = ''
        function(args)
          local range = nil;
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1];
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            };
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range });
        end
      '';
      range = true;
    };

    FormatDisable = {
      command.__raw = ''
        function(args)
          if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true;
          else
            vim.g.disable_autoformat = true;
          end
        end
      '';
      bang = true;
    };

    FormatEnable = {
      command.__raw = ''
        function()
          vim.b.disable_autoformat = false;
          vim.g.disable_autoformat = false;
        end
      '';
      bang = true;
    };

    SessionWrite = {
      nargs = 1;
      command.__raw = ''
        function(opts)
          MiniSessions.write(opts.args);
        end
      '';
    };

    SessionDelete = {
      nargs = "?";
      command.__raw = ''
        function(opts)
          if opts.args == "" then
            MiniSessions.delete(nil, { force = true });
          else
            MiniSessions.delete(opts.args, { force = true });
          end
        end
      '';
      complete.__raw = ''
        function()
          local sessions = {};
          for session_name,_ in pairs(MiniSessions.detected) do
            table.insert(sessions, session_name);
          end
          return sessions;
        end
      '';
    };
  };
}
