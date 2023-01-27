local transparency = require("core.settings").transparency
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = require("core.keymaps").telescope,
  config = function()
    local extensions_list = { "themes", "terms" }
    local telescope = require("telescope")
    local telescope_actions = require("telescope.actions.set")

    -- make telescop fold when open files
    -- see: https://github.com/nvim-telescope/telescope.nvim/issues/559
    local fixfolds = {
      hidden = true,
      attach_mappings = function(_)
        telescope_actions.select:enhance({
          post = function()
            vim.cmd(":normal! zx zM")
          end,
        })
        return true
      end,
    }
    local opts = {
      pickers = {
        buffers = fixfolds,
        file_browser = fixfolds,
        find_files = fixfolds,
        git_files = fixfolds,
        grep_string = fixfolds,
        live_grep = fixfolds,
        oldfiles = fixfolds,
        -- I probably missed some
      },
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        -- prompt_prefix = "   ",
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = transparency.winblend(),
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },
    }
    telescope.setup(opts)

    pcall(function()
      for _, ext in ipairs(extensions_list) do
        telescope.load_extension(ext)
      end
    end)
  end,
}
