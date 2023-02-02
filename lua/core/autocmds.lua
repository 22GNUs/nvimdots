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

M.open_alpha_if_no_buffers_is_opening = function()
  -- see: https://github.com/goolord/alpha-nvim/discussions/85
  local alpha_on_empty = "alpha_on_empty"
  vim.api.nvim_create_augroup(alpha_on_empty, { clear = true })
  vim.api.nvim_create_autocmd("User", {
    pattern = "BDeletePost*",
    group = alpha_on_empty,
    callback = function(event)
      local fallback_name = vim.api.nvim_buf_get_name(event.buf)
      local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
      local fallback_on_empty = fallback_name == "" and fallback_ft == ""
      if fallback_on_empty then
        local ok, api = pcall(require, "nvim-tree.api")
        if ok then
          -- if nvim-tree is loaded and opened, then close it
          api.tree.close()
        end

        vim.cmd("Alpha")
        vim.cmd(event.buf .. "bwipeout")
      end
    end,
  })
end

return M
