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

M.whichkey = {
  {
    "<leader>wK",
    function()
      vim.cmd("WhichKey")
    end,
    desc = "which-key all keymaps",
  },
  {
    "<leader>wk",
    function()
      local input = vim.fn.input("WhichKey: ")
      vim.cmd("WhichKey " .. input)
    end,
    desc = "which-key query lookup",
  },
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
    desc = "jump to next hunk",
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
    desc = "jump to prev hunk",
  },

  -- Actions
  {
    "<leader>rh",
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "reset hunk",
  },

  {
    "<leader>ph",
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "preview hunk",
  },

  {
    "<leader>gb",
    function()
      package.loaded.gitsigns.blame_line()
    end,
    desc = "blame line",
  },

  {
    "<leader>td",
    function()
      require("gitsigns").toggle_deleted()
    end,
    desc = "toggle deleted",
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

M.lspconfig = {
  { "gD", vim.lsp.buf.declaration, desc = "lsp declaration" },
  { "gd", vim.lsp.buf.definition, desc = "lsp definition" },
  { "gr", vim.lsp.buf.references, desc = "lsp references" },
  { "K", vim.lsp.buf.hover, desc = "lsp hover" },
  { "gi", vim.lsp.buf.implementation, desc = "lsp implementation" },
  { "[d", vim.diagnostic.goto_prev, desc = "goto prev" },
  { "d]", vim.diagnostic.goto_next, desc = "goto_next" },
  { "<leader>ls", vim.lsp.buf.signature_help, desc = "lsp signature_help" },
  { "<leader>D", vim.lsp.buf.type_definition, desc = "lsp definition type" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "lsp code_action" },
  { "<leader>f", vim.diagnostic.open_float, desc = "floating diagnostic" },
  { "<leader>q", vim.diagnostic.setloclist, desc = "diagnostic setloclist" },
  { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "add workspace folder" },
  { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "remove workspace folder" },
  {
    "<leader>ra",
    function()
      require("ui.renamer").open()
    end,
    desc = "lsp rename",
  },
  {
    "<leader>fm",
    function()
      vim.lsp.buf.format({ async = true })
    end,
    desc = "lsp formatting",
  },
  {
    "<leader>wl",
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    desc = "list workspace folders",
  },
}

return M
