local event = require("core.lazy").event
return {
  {
    "nvim-tree/nvim-web-devicons",
    module = true,
  },
  {
    "nvim-lua/plenary.nvim",
    name = "plenary",
    module = true,
  },
  {
    "norcalli/nvim-colorizer.lua",
    name = "colorizer",
    event = event.OnFileOpen,
    config = function()
      require("colorizer").setup()
    end,
  },
}
