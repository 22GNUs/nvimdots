local merge_tb = vim.tbl_deep_extend
local M = {}

local theme_setting = require("core.settings").theme

M.get_theme_paletts = function()
  -- only catppuccin for now
  if theme_setting.name == "catppuccin" then
    return require("catppuccin.palettes").get_palette(theme_setting.flavour)
  end
end

M.get_theme_highlights = function()
  if theme_setting.name == "catppuccin" then
    return require("catppuccin.groups.integrations.bufferline").get()
  end
end

-- normally no need to call it, only when keybinds are dynamicly load
M.bind_mappings = function(section, mapping_opts)
  local keymaps = require("core.keymaps")
  local values = keymaps[section]
  if values ~= nil then
    for _, binding in pairs(values) do
      local key = binding[1]
      local cmd = binding[2]
      local desc = binding.desc
      local mode = binding.mode and binding.mode or "n"
      local opts = merge_tb("force", { desc = desc }, mapping_opts or {})
      vim.keymap.set(mode, key, cmd, opts)
    end
  end
end

return M
