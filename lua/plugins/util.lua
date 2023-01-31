return {
  -- plenary
  {
    "nvim-lua/plenary.nvim",
    name = "plenary",
    module = true,
  },
  -- wakatime
  {
    "wakatime/vim-wakatime",
    event = require("core.lazy").event.VeryLazy,
  },
}
