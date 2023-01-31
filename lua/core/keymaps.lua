local M = {}

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.general = {
  -- mode i
  { "<C-b>", "<ESC>^i", desc = "beginning of line", mode = "i" },
  { "<C-e>", "<End>", desc = "end of line", mode = "i" },
  -- navigate within insert mode
  { "<C-h>", "<Left>", "move left", mode = "i" },
  { "<C-l>", "<Right>", desc = "move right", mode = "i" },
  { "<C-j>", "<Down>", desc = "move down", mode = "i" },
  { "<C-k>", "<Up>", desc = "move up", mode = "i" },

  -- mode n
  -- switch between windows
  { "<ESC>", "<cmd> noh <CR>", desc = "no highlight" },
  { "<C-h>", "<C-w>h", desc = "window left" },
  { "<C-l>", "<C-w>l", desc = "window right" },
  { "<C-j>", "<C-w>j", desc = "window down" },
  { "<C-k>", "<C-w>k", desc = "window up" },
  -- save
  { "<C-s>", "<cmd> w <CR>", desc = "save file" },
  -- Copy all
  { "<C-c>", "<cmd> %y+ <CR>", desc = "copy whole file" },
  -- line numbers
  { "<leader>n", "<cmd> set nu! <CR>", desc = "toggle line number" },
  { "<leader>rn", "<cmd> set rnu! <CR>", desc = "toggle relative number" },
  -- new buffer
  { "<leader>b", "<cmd> enew <CR>", desc = "new buffer" },
  { "<leader>ss", "<cmd> source % <CR>", desc = "source current" },

  -- mode t
  { "<C-x>", termcodes("<C-\\><C-N>"), desc = "escape terminal mode", mode = "t" },
}

M.nvimtree = {
  { "<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "toggle nvimtree" },
  { "<leader>e", "<cmd> NvimTreeFocus <CR>", desc = "focus nvimtree" },
}

M.buffer = {
  { "<leader>x", "<cmd> Bdelete <CR>", desc = "close buffer" },
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
  { "<leader>fr", "<cmd> Telescope oldfiles <CR>", desc = "find old files" },
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

M.focus = {
  { "<leader>wh", ":FocusSplitLeft<CR>", desc = "focus left" },
  { "<leader>wj", ":FocusSplitDown<CR>", desc = "focus left" },
  { "<leader>wk", ":FocusSplitUp<CR>", desc = "focus left" },
  { "<leader>wl", ":FocusSplitRight<CR>", desc = "focus left" },
  { "<leader>wn", ":FocusSplitNicely<CR>", desc = "focus nicely" },
}
return M
