local palettes = require("core.utils").get_theme_paletts()
local ui = require("ui.icons").ui
local separator = { left = ui.left_separator, right = ui.right_separator }

local filename = {
  "filename",
  color = { bg = palettes.blue, fg = palettes.surface0 },
  separator = separator,
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = palettes.surface0 },
  separator = separator,
}

local space = {
  function()
    return " "
  end,
}

local location = {
  "location",
  color = { bg = palettes.flamingo, fg = palettes.surface0 },
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
  color = { bg = palettes.surface0, fg = palettes.surface0 },
  separator = separator,
}

local modes = {
  "mode",
  fmt = function(str)
    return str:sub(1, 1)
  end,
  -- use theme colors
  color = { fg = palettes.base, bg = palettes.lavender },
  separator = separator,
  icon = { "", align = "left" },
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

local theme = {
  normal = {
    a = {},
    b = {},
    c = {},
    x = {},
    y = {},
    z = {},
  },
  insert = { a = { fg = palettes.base, bg = palettes.peach } },
  visual = { a = { fg = palettes.base, bg = palettes.sky } },
  replace = { a = { fg = palettes.base, bg = palettes.maroon } },
}

return {
  opts = {
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
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
        space,
        filetype,
        filename,
      },
      lualine_c = {
        space,
        branch,
        diff,
      },
      lualine_x = {
        dia,
        lsp,
        space,
      },
      lualine_y = {
        encoding,
        fileformat,
      },
      lualine_z = {
        location,
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
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
