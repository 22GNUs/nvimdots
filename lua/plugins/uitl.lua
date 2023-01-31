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
    -- enable just for some filetypes
    ft = { "lua", "go", "markdown" },
  },
}
