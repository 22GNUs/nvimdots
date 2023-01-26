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
return M
