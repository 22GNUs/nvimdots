return {
  {
    "nvim-lua/plenary.nvim",
    name = "plenary",
    module = true,
  },
  {
    "wakatime/vim-wakatime",
    event = require("core.lazy").event.VeryLazy,
  },
}
