local vim_icons = {
  function()
    return " "
  end,
  separator = { left = "", right = "" },
  color = { bg = "#313244", fg = "#80A7EA" },
}

local filename = {
  "filename",
  color = { bg = "#80A7EA", fg = "#242735" },
  separator = { left = "", right = "" },
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = "#313244" },
  separator = { left = "", right = "" },
}

local fileformat = {
  "fileformat",
  color = { bg = "#b4befe", fg = "#313244" },
  separator = { left = "", right = "" },
}

local encoding = {
  "encoding",
  color = { bg = "#313244", fg = "#80A7EA" },
  separator = { left = "", right = "" },
}

local branch = {
  "branch",
  color = { bg = "#a6e3a1", fg = "#313244" },
  separator = { left = "", right = "" },
}

local diff = {
  "diff",
  color = { bg = "#313244", fg = "#313244" },
  separator = { left = "", right = "" },
}

local modes = {
  "mode",
  fmt = function(str)
    return str:sub(1, 1)
  end,
  color = { bg = "#fab387		", fg = "#1e1e2e" },
  separator = { left = "", right = "" },
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
  color = { bg = "#313244", fg = "#80A7EA" },
  separator = { left = "", right = "" },
}

local lsp = {
  function()
    return getLspName()
  end,
  separator = { left = "", right = "" },
  color = { bg = "#f38ba8", fg = "#1e1e2e" },
}

return {
  "nvim-lualine/lualine.nvim",
  event = require("core.lazy").event.OnFileOpen,
  dependencies = { "nvim-web-devicons", "nvim-lspconfig" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "catppuccin",
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
        --{ 'mode', fmt = function(str) return str:gsub(str, "  ") end },
        modes,
        vim_icons,
        --{ 'mode', fmt = function(str) return str:sub(1, 1) end },
      },
      lualine_b = {
        filename,
        filetype,
        branch,
        diff,
      },
      lualine_x = {
        encoding,
        fileformat,
      },
      lualine_y = {
        dia,
        lsp,
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
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
