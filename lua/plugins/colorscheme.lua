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
        mocha = {
          -- new added
          sun = "#FFE9B6",
          baby_pink = "#FFA5C3",
          nord_blue = "#8CB2F0",
          -- overrided
          rosewater = "#F5E0DC",
          flamingo = "#F2CDCD",
          pink = "#F5C2E7",
          mauve = "#DDB6F2",
          red = "#F38BA8",
          maroon = "#EBA0AC",
          peach = "#F8BD96",
          yellow = "#FAE3B0",
          green = "#ABE9B3",
          teal = "#B5E8E0",
          sky = "#89DCEB",
          sapphire = "#74C7EC",
          blue = "#89B4FA",
          -- lavender = "#c7d1ff",
        },
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

            -- treesitter.
            ["@text"] = { fg = cp.text },
            ["@punctuation.delimiter"] = { fg = cp.flamingo },
            ["@punctuation.special"] = { fg = cp.baby_pink },
            ["@punctuation.bracket"] = { fg = cp.overlay2 },

            ["@field"] = { fg = cp.teal },
            ["@property"] = { fg = cp.teal },
            ["@constructor"] = { fg = cp.nord_blue, style = { "italic", "bold" } },
            ["@method"] = { fg = cp.nord_blue, style = { "italic" } },
            ["@function.macro"] = { fg = cp.blue, style = {} },
            ["@parameter"] = { fg = cp.pink },

            ["@type.qualifier"] = { link = "@keyword" },
            ["@namespace"] = { fg = cp.text, style = {} },
            ["@include"] = { fg = cp.mauve, style = { "italic" } },
            ["@variable"] = { fg = cp.text },
            ["@type"] = { fg = cp.lavender },
            ["@type.definition"] = { fg = cp.sun },
            ["@storageclass"] = { fg = cp.sun },
            ["@structure"] = { fg = cp.sun },
            ["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
            ["@tag"] = { fg = cp.mauve },
            ["@tag.delimiter"] = { fg = cp.flamingo },

            ["@constant"] = { fg = cp.mauve },
            ["@define"] = { fg = cp.sun },
            ["@boolean"] = { fg = cp.peach },
            ["@number"] = { fg = cp.peach },
            ["@float"] = { fg = cp.peach },

            ["@conditional"] = { fg = cp.sky, style = { "italic", "bold" } },
            ["@repeat"] = { fg = cp.sky, style = { "italic", "bold" } },
            ["@exception"] = { fg = cp.sky, style = { "italic", "bold" } },
            ["@labal"] = { fg = cp.flamingo },
            ["@operator"] = { fg = cp.flamingo },
            ["@keyword"] = { fg = cp.baby_pink },
            ["@keyword.function"] = { fg = cp.sky },
            ["@keyword.return"] = { fg = cp.maroon, style = {} },

            ["@field.lua"] = { fg = cp.lavender },
            ["@keyword.function.typescript"] = { fg = cp.baby_pink, style = { "italic" } },
            ["@method.java"] = { fg = cp.nord_blue, style = { "italic" } },
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
