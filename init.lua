-- be sure to load options first
require("core.options")
if vim.g.vscode == nil then
  require("gui")
  require("core.autocmds")
  -- bind general keymaps
  require("core.utils").bind_mappings("general")
  -- lazy load init
  require("core.lazy").setup()
end
