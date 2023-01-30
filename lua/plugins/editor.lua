local transparency = require("core.settings").transparency
local event = require("core.lazy").event

return {
  -- which key
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`" },
    opts = {
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "  ", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },

      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      operators = { gc = "Comments" },

      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },

      window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
        winblend = transparency.winblend(),
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 6, -- spacing between columns
        align = "left", -- align columns left, center or right
      },

      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
      },

      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
    },
    init = function()
      require("core.utils").bind_mappings("whichkey")
    end,
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    event = event.OnFileOpen,
    opts = {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = "│",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = "│",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "_",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "‾",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "~",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
    },
    keys = require("core.keymaps").gitsigns,
  },

  -- focus
  {
    "beauwilliams/focus.nvim",
    name = "focus",
    keys = require("core.keymaps").focus,
    config = function(self)
      require(self.name).setup()
    end,
  },
}
