return {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
  event = require("core.lazy").event.OnFileOpen,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup(opts)
  end,
}
