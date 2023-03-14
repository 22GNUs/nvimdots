local paletts = require("core.utils").get_theme_paletts()
return {
  "akinsho/toggleterm.nvim",
  keys = require("core.keymaps").toggleterm,
  opts = {
    open_mapping = [[<c-\>]],
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    shade_terminals = true,
    shade_filetypes = {},
    highlights = {
      FloatBorder = {
        guifg = paletts.blue,
      },
    },
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    float_opts = {
      border = "double",
      winblend = require("core.settings").transparency.winblend(),
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
