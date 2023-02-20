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
  -- over P to paste last yank(exclude last delete)
  { "P", '"0p', desc = "paste last yank" },
  -- Copy all
  { "<C-c>", "<cmd> %y+ <CR>", desc = "copy whole file" },
  -- line numbers
  { "<leader>ln", "<cmd> set nu! <CR>", desc = "toggle line number" },
  { "<leader>lr", "<cmd> set rnu! <CR>", desc = "toggle relative number" },
  -- new buffer
  { "<leader>bn", "<cmd> enew <CR>", desc = "new buffer" },
  { "<leader>ss", "<cmd> source % <CR>", desc = "source current" },
  -- update plugins
  { "<leader>uu", ":Lazy update <CR>", desc = "Update plugins" },

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
    "<leader>ka",
    function()
      vim.cmd("WhichKey")
    end,
    desc = "which-key all keymaps",
  },
  {
    "<leader>kq",
    function()
      local input = vim.fn.input("WhichKey: ")
      vim.cmd("WhichKey " .. input)
    end,
    desc = "which-key query lookup",
  },
}

M.gitsigns = {
  {
    "]g",
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
    "[g",
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
  {
    "<leader>gr",
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "reset hunk",
  },
  {
    "<leader>gh",
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
    "<leader>gd",
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
  { "<leader>fn", "<cmd> Noice telescope <CR>", desc = "find notices" },
  { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "help page" },
  { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "find oldfiles" },
  { "<leader>ft", "<cmd> Telescope keymaps <CR>", desc = "show keys" },

  -- git
  { "<leader>gm", "<cmd> Telescope git_commits <CR>", desc = "git commits" },
  { "<leader>gt", "<cmd> Telescope git_status <CR>", desc = "git status" },
}

M.lspconfig = {
  { "gD", vim.lsp.buf.declaration, desc = "lsp declaration" },
  { "gd", vim.lsp.buf.definition, desc = "lsp definition" },
  { "gr", vim.lsp.buf.references, desc = "lsp references" },
  { "gi", vim.lsp.buf.implementation, desc = "lsp implementation" },
  { "[d", vim.diagnostic.goto_prev, desc = "goto prev diagnostic" },
  { "]d", vim.diagnostic.goto_next, desc = "goto next diagnostic" },
  { "<leader>ck", vim.lsp.buf.hover, desc = "lsp hover" },
  { "<leader>cs", vim.lsp.buf.signature_help, desc = "lsp signature_help" },
  { "<leader>cd", vim.lsp.buf.type_definition, desc = "lsp definition type" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "lsp code_action" },
  { "<leader>df", vim.diagnostic.open_float, desc = "floating diagnostic" },
  -- use trouble instead
  -- { "<leader>dq", vim.diagnostic.setloclist, desc = "diagnostic setloclist" },
  { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "add workspace folder" },
  { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "remove workspace folder" },
  { "<leader>rr", vim.lsp.buf.rename, desc = "lsp rename" },
  {
    "<leader>ws",
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    desc = "show workspace folders",
  },
  {
    "<leader>fm",
    function()
      vim.lsp.buf.format({ async = true })
    end,
    desc = "lsp formatting",
  },
}

M.focus = {
  { "<leader>wh", ":FocusSplitLeft<CR>", desc = "focus left", silent = true },
  { "<leader>wj", ":FocusSplitDown<CR>", desc = "focus down", silent = true },
  { "<leader>wk", ":FocusSplitUp<CR>", desc = "focus up", silent = true },
  { "<leader>wl", ":FocusSplitRight<CR>", desc = "focus right", silent = true },
  { "<leader>wn", ":FocusSplitNicely<CR>", desc = "focus nicely", silent = true },
}

M.toggleterm = {
  { "<leader>th", ":ToggleTerm<CR>", desc = "toggle horizontal term", silent = true },
  { "<leader>tf", ":ToggleTerm direction=float<CR>", desc = "toggle float term", silent = true },
  {
    "<leader>tg",
    function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        float_opts = {
          border = "double",
        },
        hidden = true,
      })
      lazygit:toggle()
    end,
    desc = "toggle lazygit term",
    silent = true,
  },
  {
    "<leader>tm",
    function()
      local ft = vim.bo.filetype
      if ft ~= "markdown" then
        vim.notify("Current ft is not markdown!")
        return
      end
      local bufname = vim.api.nvim_buf_get_name(0)
      vim.pretty_print(bufname)
      local Terminal = require("toggleterm.terminal").Terminal
      local glow = Terminal:new({
        cmd = string.format('glow -p "%s"', bufname),
        direction = "float",
        hidden = false,
        float_opts = {
          border = "double",
        },
      })
      glow:toggle()
    end,
    desc = "toggle markdown preview",
    silent = true,
  },
}

M.zenmode = {
  { "<leader>tz", ":ZenMode<CR>", desc = "toggle zen mode", silent = true },
}

M.trouble = {
  { "<leader>dx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
  { "<leader>dX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
  { "<leader>dL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
  { "<leader>dq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
}

M.groups = {
  mode = { "n", "v" },
  ["g"] = { name = "+goto" },
  ["gz"] = { name = "+surround" },
  ["]"] = { name = "+next" },
  ["["] = { name = "+prev" },
  ["<leader>b"] = { name = "+buffer" },
  ["<leader>c"] = { name = "+code" },
  ["<leader>d"] = { name = "+diagnostic" },
  ["<leader>f"] = { name = "+find/format" },
  ["<leader>g"] = { name = "+git" },
  ["<leader>k"] = { name = "+keymap" },
  ["<leader>l"] = { name = "+line" },
  ["<leader>r"] = { name = "+refactor/reset" },
  ["<leader>s"] = { name = "+source" },
  ["<leader>t"] = { name = "+terminal/toggle" },
  ["<leader>u"] = { name = "+update" },
  ["<leader>w"] = { name = "+window/workspace" },
}
return M
