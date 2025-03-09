local M = {}

M.is_buf_valid = function(buf)
  return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
end

M.list_valid_bufs = function()
  local all_bufs = vim.api.nvim_list_bufs()
  return vim.tbl_filter(M.is_buf_valid, all_bufs)
end

return M
