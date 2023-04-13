return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      styles = {
        comments = { "italic" },
        properties = { "italic" },
        functions = { "italic", "bold" },
        keywords = { "italic" },
        operators = { "bold" },
        conditionals = { "bold" },
        loops = { "bold" },
        booleans = { "bold", "italic" },
        numbers = {},
        types = {},
        strings = {},
        variables = {},
      },
      color_overrides = {
        mocha = {},
      },
      highlight_overrides = {
        mocha = function(cp)
          local border_color = cp.blue
          return {
            -- for borders
            CmpBorder = { fg = border_color },
            CmpDocBorder = { fg = border_color },
            TelescopeBorder = { fg = border_color },
            NoiceCmdlinePopupBorder = { fg = border_color },

            AlphaHeader = { fg = cp.lavender },

            -- whichkey
            WhichKeyFloat = { bg = vim.g.transparency and cp.none or cp.base },

            -- notice
            NotifyBackground = { bg = cp.base },

            -- outline's focused symbol
            FocusedSymbol = { fg = cp.baby_pink },

            -- Remove cursorLine bg
            CursorLine = { bg = cp.none },
            -- Hide fold bg
            Folded = { bg = cp.none },

            -- For trouble.nvim
            TroubleNormal = { bg = vim.g.transparency and cp.none or cp.base },
            TroubleText = { fg = cp.baby_pink },
          }
        end,
      },
      transparent_background = vim.g.transparency,
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        mason = true,
        treesitter = true,
        which_key = true,
        lsp_saga = true,
        lsp_trouble = true,
        dap = { enabled = true, enable_ui = true },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        mini = false,
        noice = true,
        notify = true,
      },
    },
    config = function(self, opts)
      require(self.name).setup(opts)
      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
