-- Some global settings
return {
  diagnostics = {
    update_in_insert = true,
  },
  theme = {
    name = "catppuccin",
    flavour = "mocha",
  },
  transparency = {
    winblend = function()
      return vim.g.transparency and 0 or 25
    end,
    pumblend = function()
      return 0
    end,
  },
}
