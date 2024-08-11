{
  programs.nixvim.userCommands = {
    W.command = "write"; # I'm clumsy

    Format = {
      command.__raw = ''
        function()
        	require('conform').format({ timeout_ms = 500, lsp_fallback = true });
        end
      '';
      range = true;
    };

    WriteSession = {
      nargs = 1;
      command.__raw = ''
        function(opts)
          MiniSessions.write(opts.args);
        end
      '';
    };

    DeleteSession = {
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
