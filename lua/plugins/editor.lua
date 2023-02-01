local transparency = require("core.settings").transparency
local event = require("core.lazy").event

return {
  -- which key
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "z", "g" },
    opts = {
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "  ", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },

      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      operators = { gc = "Comments" },

      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },

      window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
        winblend = transparency.winblend(),
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 6, -- spacing between columns
        align = "left", -- align columns left, center or right
      },

      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
      },

      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
    },
    init = function()
      require("core.utils").bind_mappings("whichkey")
    end,
  },
  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    event = event.BufReadPre,
    opts = {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = "│",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = "│",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "_",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "‾",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "~",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
    },
    keys = require("core.keymaps").gitsigns,
  },
  -- focus
  {
    "beauwilliams/focus.nvim",
    name = "focus",
    keys = require("core.keymaps").focus,
    config = function(self)
      require(self.name).setup()
    end,
  },
  -- nvimtree
  {
    "nvim-tree/nvim-tree.lua",
    keys = require("core.keymaps").nvimtree,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      local present, nvimtree = pcall(require, "nvim-tree")
      if not present then
        return
      end
      local options = {
        filters = {
          dotfiles = false,
          custom = { "^\\.git", ".DS_Store" },
          exclude = {},
        },
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
        view = {
          adaptive_size = true,
          side = "left",
          width = 25,
          hide_root_folder = true,
        },
        git = {
          enable = false,
          ignore = true,
        },
        filesystem_watchers = {
          enable = true,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
              -- enable window picker to replace alpha when nvim-tree open a new file
              -- see: https://github.com/nvim-tree/nvim-tree.lua/issues/1146
              enable = true,
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "diff" },
                buftype = { "terminal", "help" },
              },
            },
          },
        },
        renderer = {
          highlight_git = false,
          highlight_opened_files = "none",

          indent_markers = {
            enable = false,
          },

          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = false,
            },

            glyphs = {
              default = "",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      }
      nvimtree.setup(options)
    end,
    dependencies = { "nvim-web-devicons" },
  },
  -- telescope
  {
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
  },
}
