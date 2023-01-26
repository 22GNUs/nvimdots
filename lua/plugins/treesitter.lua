local event = require("core.lazy").event
return {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
  event = event.OnFileOpen,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "json",
      "toml",
      "markdown",
      "bash",
      "lua",
      "vim",
      "go",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
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
