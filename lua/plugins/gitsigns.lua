local event = require("core.lazy").event
return {
  "lewis6991/gitsigns.nvim",
  ft = "gitcommit",
  event = event.VeryLazy,
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
        text = "",
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
  keys = {
    {
      "]c",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      desc = "Jump to next hunk",
    },

    {
      "[c",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      desc = "Jump to prev hunk",
    },

    -- Actions
    {
      "<leader>rh",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Reset hunk",
    },

    {
      "<leader>ph",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Preview hunk",
    },

    {
      "<leader>gb",
      function()
        package.loaded.gitsigns.blame_line()
      end,
      desc = "Blame line",
    },

    {
      "<leader>td",
      function()
        require("gitsigns").toggle_deleted()
      end,
      desc = "Toggle deleted",
    },
  },
}
