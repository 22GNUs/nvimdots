return {
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
        open_on_setup = false,
        ignore_ft_on_setup = { "alpha" },
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
}
