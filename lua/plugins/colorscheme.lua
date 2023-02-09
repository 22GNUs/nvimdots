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
      color_overrides = {},
      highlight_overrides = {
        mocha = function(cp)
          local border_color = cp.blue
          return {
            -- for borders
            CmpBorder = { fg = border_color },
            CmpDocBorder = { fg = border_color },
            TelescopeBorder = { fg = border_color },
            AlphaHeader = { fg = cp.lavender },

            -- Renamer
            RenamerBorder = { fg = border_color },
            RenamerTitle = { fg = cp.blue },

            -- Remove cursorLine bg
            CursorLine = { bg = cp.none },
            -- Hide fold bg
            Folded = { bg = cp.none },

            -- For trouble.nvim
            TroubleNormal = { bg = cp.base },
            TroubleText = { fg = cp.maroon },

            -- languages syntax
            Keyword = { fg = cp.pink },
            Type = { fg = cp.blue },
            Typedef = { fg = cp.yellow },
            StorageClass = { fg = cp.red, style = { "italic" } },

            -- treesitter.
            ["@field"] = { fg = cp.rosewater },
            ["@property"] = { fg = cp.yellow },
            ["@include"] = { fg = cp.teal },
            ["@keyword.operator"] = { fg = cp.sky },
            ["@punctuation.special"] = { fg = cp.maroon },
            ["@constructor"] = { fg = cp.lavender },
            ["@exception"] = { fg = cp.peach },
            ["@constant.builtin"] = { fg = cp.lavender },
            ["@type.qualifier"] = { link = "@keyword" },
            ["@variable.builtin"] = { fg = cp.red, style = { "italic" } },
            ["@function.macro"] = { fg = cp.red, style = {} },
            ["@parameter"] = { fg = cp.rosewater },
            ["@keyword"] = { fg = cp.red, style = { "italic" } },
            ["@keyword.function"] = { fg = cp.maroon },
            ["@keyword.return"] = { fg = cp.pink, style = {} },
            ["@method"] = { fg = cp.blue, style = { "italic" } },
            ["@namespace"] = { fg = cp.rosewater, style = {} },
            ["@punctuation.delimiter"] = { fg = cp.teal },
            ["@punctuation.bracket"] = { fg = cp.overlay2 },
            ["@type"] = { fg = cp.yellow },
            ["@variable"] = { fg = cp.text },
            ["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
            ["@tag"] = { fg = cp.peach },
            ["@tag.delimiter"] = { fg = cp.maroon },
            ["@text"] = { fg = cp.text },
            ["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
            ["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },
            ["@field.lua"] = { fg = cp.lavender },
            ["@constructor.lua"] = { fg = cp.flamingo },
            ["@constant.java"] = { fg = cp.teal },
            ["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
            ["@type.css"] = { fg = cp.lavender },
            ["@property.css"] = { fg = cp.yellow, style = { "italic" } },
            ["@type.builtin.c"] = { fg = cp.yellow, style = {} },
            ["@property.cpp"] = { fg = cp.text },
            ["@type.builtin.cpp"] = { fg = cp.yellow, style = {} },

            ["@operator"] = { fg = cp.sky },
            ["@float"] = { fg = cp.peach },
            ["@number"] = { fg = cp.peach },
            ["@boolean"] = { fg = cp.peach },
            ["@constant"] = { fg = cp.peach },
            ["@conditional"] = { fg = cp.mauve },
            ["@repeat"] = { fg = cp.mauve },
            ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
            ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
            ["@function"] = { fg = cp.blue },
            ["@text.note"] = { fg = cp.base, bg = cp.blue },
            ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
            ["@text.danger"] = { fg = cp.base, bg = cp.red },
            ["@constant.macro"] = { fg = cp.mauve },
            ["@string"] = { fg = cp.green },
            ["@string.regex"] = { fg = cp.peach },
            ["@label"] = { fg = cp.blue },
            ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
            ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
            ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
            ["@text.title"] = { fg = cp.blue, style = { "bold" } },
            ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
            ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
            ["@string.escape"] = { fg = cp.pink },
            ["@property.toml"] = { fg = cp.blue },
            ["@field.yaml"] = { fg = cp.blue },
            ["@label.json"] = { fg = cp.blue },
            ["@constructor.typescript"] = { fg = cp.lavender },
            ["@constructor.tsx"] = { fg = cp.lavender },
            ["@tag.attribute.tsx"] = { fg = cp.mauve },
            ["@symbol"] = { fg = cp.flamingo },
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
        notify = false,
        mini = false,
      },
    },
    config = function(self, opts)
      require(self.name).setup(opts)
      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
