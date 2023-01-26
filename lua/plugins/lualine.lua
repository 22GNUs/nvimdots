local palettes = require("core.utils").get_theme_paletts()
local ui = require("ui.icons").ui
local separator = { left = ui.left_separator, right = ui.right_separator }

local filename = {
  "filename",
  color = { bg = palettes.blue, fg = palettes.surface1 },
  separator = separator,
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = palettes.surface0 },
  separator = separator,
}

local fileformat = {
  "fileformat",
  color = { bg = palettes.mauve, fg = palettes.surface0 },
  separator = separator,
}

local encoding = {
  "encoding",
  color = { bg = palettes.surface0, fg = palettes.blue },
  separator = separator,
}

local branch = {
  "branch",
  color = { bg = palettes.green, fg = palettes.surface0 },
  separator = separator,
}

local diff = {
  "diff",
  color = { bg = palettes.base, fg = palettes.surface0 },
  separator = separator,
}

local modes = {
  "mode",
  fmt = function(str)
    return str:sub(1, 1)
  end,
  color = { bg = palettes.peach, fg = palettes.base },
  separator = separator,
}

local function getLspName()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return "  " .. client.name
    end
  end
  return "  " .. msg
end

local dia = {
  "diagnostics",
  color = { bg = palettes.surface0, fg = palettes.surface0 },
  separator = separator,
}

local lsp = {
  function()
    return getLspName()
  end,
  separator = separator,
  color = { bg = palettes.pink, fg = palettes.base },
}

local event = require("core.lazy").event
local theme_settings = require("core.settings").theme

return {
  "nvim-lualine/lualine.nvim",
  event = event.VeryLazy,
  dependencies = { "nvim-web-devicons", "nvim-lspconfig" },
  opts = {
    options = {
      icons_enabled = true,
      theme = theme_settings.name,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },

    sections = {
      lualine_a = {
        modes,
      },
      lualine_b = {
        filetype,
        filename,
        branch,
        diff,
      },
      lualine_c = {},
      lualine_x = {
        dia,
        lsp,
      },
      lualine_y = {
        encoding,
        fileformat,
      },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {
      "quickfix",
      "nvim-tree",
      "nvim-dap-ui",
      "toggleterm",
    },
  },
}
