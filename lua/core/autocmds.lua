local M = {}

M.reopen_lazy_when_alpha_ready = function()
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end
end

M.hide_status_line_when_alpha_open = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
      vim.opt.laststatus = 0
    end,
  })
end

return M
