local ui = require("ui.icons").ui
return {
  "nvim-lualine/lualine.nvim",
  event = require("core.lazy").event.VeryLazy,
  dependencies = { "nvim-web-devicons", "nvim-lspconfig" },
  opts = {
    options = {
      theme = "catppuccin",
      icons_enabled = true,
      component_separators = { left = ui.left_separator_1, right = ui.right_separator_1 },
      section_separators = { left = ui.left_separator_2, right = ui.right_separator_2 },
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
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
      "nvim-tree",
      "symbols-outline",
      "toggleterm",
      "fugitive",
    },
  },
}
