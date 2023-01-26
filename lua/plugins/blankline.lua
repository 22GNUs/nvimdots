return {
  "lukas-reineke/indent-blankline.nvim",
  event = require("core.lazy").event.OnFileOpen,
  name = "indent_blankline",
  opts = {
    space_char_blankline = " ",
    indentLine_enabled = 1,
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
      "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = false,
    show_current_context_start = false,
    char_highlight_list = {
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent6",
      "IndentBlanklineIndent5",
    },
  },
}
