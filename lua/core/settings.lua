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
      return vim.g.transparency and 0 or 15
    end,
    pumblend = function()
      return vim.g.transparency and 0 or 15
    end,
  },
}
