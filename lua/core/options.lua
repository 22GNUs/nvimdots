local opt = vim.opt
local g = vim.g
local transparency = require("core.settings").transparency

g.mapleader = " "
g.transparency = true
g.theme_switcher_loaded = false

opt.laststatus = 0 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.swapfile = false

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- list
vim.o.list = true
vim.o.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
vim.o.linebreak = true
vim.o.showbreak = "↳  "

-- transparency
vim.o.winblend = transparency.winblend()
vim.o.pumblend = transparency.pumblend()

-- see: https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
-- fold settings
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
vim.wo.fillchars = "fold:\\"
vim.wo.foldnestmax = 5
vim.wo.foldminlines = 1

-- close other buffers and keep current opened only
-- see: https://tech.serhatteker.com/post/2020-06/close-all-buffers-but-current-in-vim/
vim.cmd("silent! command! BufCurOnly execute '%bdelete|edit#|bdelete#'")

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
