local event = require("core.lazy").event
local keymaps = require("core.keymaps")
return {
  -- web devicons
  {
    "nvim-tree/nvim-web-devicons",
    module = true,
  },
  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
    name = "colorizer",
    event = event.BufOpen,
    config = function()
      require("colorizer").setup()
    end,
  },
  -- dashboard
  {
    "goolord/alpha-nvim",
    event = require("core.lazy").event.VimEnter,
    dependencies = {
      "nvim-web-devicons",
      "plenary",
    },
    opts = function()
      local plenary_path = require("plenary.path")
      local dashboard = require("alpha.themes.dashboard")
      local cdir = vim.fn.getcwd()
      local if_nil = vim.F.if_nil

      local nvim_web_devicons = {
        enabled = true,
        highlight = true,
      }

      local function get_extension(fn)
        local match = fn:match("^.+(%..+)$")
        local ext = ""
        if match ~= nil then
          ext = match:sub(2)
        end
        return ext
      end

      local function icon(fn)
        local nwd = require("nvim-web-devicons")
        local ext = get_extension(fn)
        return nwd.get_icon(fn, ext, { default = true })
      end

      local function file_button(fn, sc, short_fn)
        short_fn = short_fn or fn
        local ico_txt
        local fb_hl = {}

        if nvim_web_devicons.enabled then
          local ico, hl = icon(fn)
          local hl_option_type = type(nvim_web_devicons.highlight)
          if hl_option_type == "boolean" then
            if hl and nvim_web_devicons.highlight then
              table.insert(fb_hl, { hl, 0, 3 })
            end
          end
          if hl_option_type == "string" then
            table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
          end
          ico_txt = ico .. "  "
        else
          ico_txt = ""
        end
        local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. " <CR>")
        local fn_start = short_fn:match(".*[/\\]")
        if fn_start ~= nil then
          table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
        end
        file_button_el.opts.hl = fb_hl
        return file_button_el
      end

      local default_mru_ignore = { "gitcommit" }

      local mru_opts = {
        ignore = function(path, ext)
          return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
        end,
      }

      --- @param start number
      --- @param cwd string optional
      --- @param items_number number optional number of items to generate, default = 10
      local function mru(start, cwd, items_number, opts)
        opts = opts or mru_opts
        items_number = if_nil(items_number, 15)

        local oldfiles = {}
        for _, v in pairs(vim.v.oldfiles) do
          if #oldfiles == items_number then
            break
          end
          local cwd_cond
          if not cwd then
            cwd_cond = true
          else
            cwd_cond = vim.startswith(v, cwd)
          end
          local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
          if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
          end
        end
        local target_width = 35

        local tbl = {}
        for i, fn in ipairs(oldfiles) do
          local short_fn
          if cwd then
            short_fn = vim.fn.fnamemodify(fn, ":.")
          else
            short_fn = vim.fn.fnamemodify(fn, ":~")
          end

          if #short_fn > target_width then
            short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
            if #short_fn > target_width then
              short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
            end
          end

          local shortcut = tostring(i + start - 1)

          local file_button_el = file_button(fn, shortcut, short_fn)
          tbl[i] = file_button_el
        end
        return {
          type = "group",
          val = tbl,
          opts = {},
        }
      end

      local default_header = {
        type = "text",
        val = {
          [[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
          [[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
          [[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
          [[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
          [[██   ████ ███████  ██████    ████   ██ ██      ██]],

          [[                               __                ]],
          [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
          [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
          [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
          [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
          [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        },
        opts = {
          position = "center",
          hl = "AlphaHeader",
          -- wrap = "overflow";
        },
      }

      local section_mru = {
        type = "group",
        val = {
          {
            type = "text",
            val = "Recent files",
            opts = {
              hl = "SpecialComment",
              shrink_margin = false,
              position = "center",
            },
          },
          { type = "padding", val = 1 },
          {
            type = "group",
            val = function()
              return { mru(0, cdir) }
            end,
            opts = { shrink_margin = false },
          },
        },
      }

      local buttons = {
        type = "group",
        val = {
          { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
          { type = "padding", val = 1 },
          dashboard.button("e", "  New file", "<cmd>ene<CR>"),
          dashboard.button("SPC ff", "  Find file"),
          dashboard.button("SPC fw", "  Live grep"),
          -- now word for now
          -- dashboard.button("SPC p", "  Projects"),
          dashboard.button("c", "  Configuration", "<cmd>e ~/.config/nvim/init.lua <CR>"),
          dashboard.button("u", "  Update plugins", "<cmd>Lazy update<CR>"),
          dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
        },
        position = "center",
      }

      local config = {
        layout = {
          { type = "padding", val = 2 },
          default_header,
          { type = "padding", val = 2 },
          section_mru,
          { type = "padding", val = 2 },
          buttons,
        },
        opts = {
          margin = 5,
          setup = function()
            vim.cmd([[
            autocmd alpha_temp DirChanged * lua require('alpha').redraw()
            ]])
          end,
        },
      }
      return config
    end,
    config = function(_, config)
      -- originally authored by @AdamWhittingham
      local alpha = require("alpha")

      local autocmds = require("core.autocmds")
      autocmds.reopen_lazy_when_alpha_ready()
      autocmds.open_alpha_if_no_buffers_is_opening()
      alpha.setup(config)
    end,
  },
  -- lualine
  {

    "nvim-lualine/lualine.nvim",
    event = event.BufOpen,
    dependencies = { "nvim-web-devicons", "nvim-lspconfig" },
    opts = require("plugins.ui.lualine").opts,
  },
  -- blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    event = require("core.lazy").event.BufReadPre,
    name = "indent_blankline",
    opts = {
      space_char_blankline = " ",
      indentLine_enabled = 1,
      filetype_exclude = {
        "terminal",
        "alpha",
        "dashboard",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "lazy",
        "NvimTree",
        "Trouble",
        "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = false,
      show_current_context_start = false,
      char_highlight_list = {
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
    },
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-web-devicons", "famiu/bufdelete.nvim" },
    event = require("core.lazy").event.BufOpen,
    keys = require("core.keymaps").buffer,
    config = function()
      local settings = require("core.settings")
      local ui = require("ui.icons").ui
      local diagnostics = require("ui.icons").diagnostics
      local opts = {
        options = {
          number = nil,
          close_command = "Bdelete", -- can be a string | function, see "Mouse actions"
          modified_icon = ui.modified,
          indicator = {
            icon = ui.indicator, -- this should be omitted if indicator style is not 'icon'
            style = "icon",
          },
          buffer_close_icon = ui.buffer_close,
          left_trunc_marker = ui.left_trunc,
          right_trunc_marker = ui.right_trunc,
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 20,
          color_icons = true,
          show_buffer_close_icons = true,
          show_buffer_icons = true,
          show_tab_indicators = false,
          show_buffer_default_icon = true,
          diagnostics = "nvim_lsp",
          always_show_bufferline = true,
          separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' }
          offsets = {
            {
              filetype = "NvimTree",
              text = " File Explorer",
              text_align = "left",
              separator = true,
              highlight = "Directory",
              -- padding = 1,
            },
            {
              filetype = "lspsagaoutline",
              text = "Lspsaga Outline",
              text_align = "center",
              padding = 1,
            },
          },
          diagnostics_update_in_insert = settings.diagnostics.update_in_insert,
          diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and diagnostics.error
                or (e == "warning" and diagnostics.warning or diagnostics.information)
              s = s .. n .. sym
            end
            return s
          end,
        },
        -- see: https://github.com/catppuccin/nvim#special-integrations
        highlights = require("core.utils").get_theme_highlights(),
      }
      require("bufferline").setup(opts)
    end,
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    event = event.BufOpen,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "json",
        "toml",
        "yaml",
        "bash",
        "vim",
        "lua",
        "fish",
        "java",
        "go",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = {
        enable = true,
      },
      context_commentstring = { enable = true, enable_autocmd = false },
    },
    config = function(_, opts)
      -- see: https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
      -- fold settings
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldtext =
        [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
      vim.wo.fillchars = "fold:\\"
      vim.wo.foldnestmax = 5
      vim.wo.foldminlines = 1
      vim.wo.foldenable = false
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- neoscroll
  {
    "karb94/neoscroll.nvim",
    enabled = not vim.g.neovide,
    -- load before BufRead, avoid loading impact on performance
    event = event.VeryLazy,
    config = function()
      require("neoscroll").setup()
    end,
  },
  -- noice
  {
    "folke/noice.nvim",
    event = event.VeryLazy,
    cond = function()
      return not vim.g.neovide
    end,
    dependencies = {
      "nui",
      "nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          progress = {
            enabled = false,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        messages = {
          enabled = false,
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
      })
    end,
  },
  -- outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    keys = keymaps.symbolsoutline,
    opts = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = false,
      position = "right",
      relative_width = true,
      width = 25,
      auto_close = false,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = true,
      preview_bg_highlight = "Pmenu",
      autofold_depth = nil,
      auto_unfold_hover = true,
      fold_markers = { "", "" },
      wrap = false,
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
      },
      lsp_blacklist = {},
      symbol_blacklist = {},
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "🗲", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      },
    },
    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,
  },
}
