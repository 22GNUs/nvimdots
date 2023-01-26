local M = {}

M.nvimtree = {
  { "<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "toggle nvimtree" },
  { "<leader>e", "<cmd> NvimTreeFocus <CR>", desc = "focus nvimtree" },
}

M.buffer = {
  { "<leader>x", "<cmd> BufDel <CR>", desc = "close buffer" },
  { "<Tab>", "<cmd> BufferLineCycleNext <CR>", desc = "goto next buffer" },
  { "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>", desc = "goto previous buffer" },
}

M.gitsigns = {
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
}

M.telescope = {
  -- find
  { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "find files" },
  { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "find all" },
  { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
  { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "find buffers" },
  { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "help page" },
  { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "find oldfiles" },
  { "<leader>tk", "<cmd> Telescope keymaps <CR>", desc = "show keys" },

  -- git
  { "<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "git commits" },
  { "<leader>gt", "<cmd> Telescope git_status <CR>", desc = "git status" },

  -- pick a hidden term
  { "<leader>pt", "<cmd> Telescope terms <CR>", desc = "pick hidden term" },
}

return M
