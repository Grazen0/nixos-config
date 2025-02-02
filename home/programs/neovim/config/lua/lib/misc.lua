local M = {}

M.setup_on_ft = function(pattern, plugin_name, opts, extra_config)
  local autocmd_id
  autocmd_id = vim.api.nvim_create_autocmd('FileType', {
    pattern = pattern,
    callback = function()
      vim.api.nvim_del_autocmd(autocmd_id)

      local plugin = require(plugin_name)

      if type(opts) == 'function' then
        opts = opts(plugin)
      end

      plugin.setup(opts or {})

      if extra_config ~= nil then
        extra_config(plugin)
      end
    end,
  })
end

return M
