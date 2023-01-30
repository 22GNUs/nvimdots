return {
  -- friendly snippets
  {
    "rafamadriz/friendly-snippets",
    module = true,
  },
  -- luasnip
  {
    "L3MON4D3/LuaSnip",
    module = true,
    config = function()
      local luasnip = require("luasnip")
      local options = {
        history = true,
        updateevents = "TextChanged,TextChangedI",
      }

      luasnip.config.set_config(options)
      -- See https://github.com/L3MON4D3/LuaSnip/issues/525
      luasnip.setup({
        region_check_events = "CursorHold,InsertLeave,InsertEnter",
        -- those are for removing deleted snippets, also a common problem
        delete_check_events = "TextChanged,InsertEnter",
      })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.luasnippets_path or "" })
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Default "InsertLeave" is not working, delete it and rebinding "ModeChanged"
      -- See: https://www.reddit.com/r/neovim/comments/um7p7u/nvim_nvimcmp_luasnip_jumps_to_previous_snippets/
      -- See: https://github.com/L3MON4D3/LuaSnip/issues/258
      -- vim.api.nvim_del_autocmd "InsertLeave"
      vim.api.nvim_create_autocmd("ModeChanged", {
        callback = function()
          if
            ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
            and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  -- autopairs
  {
    "windwp/nvim-autopairs",
    name = "nvim-autopairs",
    dependencies = "nvim-cmp",
    event = require("core.lazy").event.InsertEnter,
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(self, opts)
      require(self.name).setup(opts)
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = require("core.lazy").event.InsertEnter,
    dependencies = {
      "friendly-snippets",
      "LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    config = function()
      vim.o.completeopt = "menu,menuone,noselect"
      local cmp = require("cmp")
      local cmp_window = require("cmp.utils.window")
      local lspkind = require("lspkind")
      cmp_window.info_ = cmp_window.info
      cmp_window.info = function(self)
        local info = self:info_()
        info.scrollable = false
        return info
      end

      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      local icons = {
        kind = require("ui.icons").kind,
        type = require("ui.icons").type,
        cmp = require("ui.icons").cmp,
      }

      local options = {
        window = {
          completion = {
            border = border("CmpBorder"),
            max_width = 80,
            max_height = 20,
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = border("CmpDocBorder"),
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
              symbol_map = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp),
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"
            return kind
          end,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- See: https://github.com/L3MON4D3/LuaSnip/issues/532
            elseif require("luasnip").expand_or_locally_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        sources = {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      }
      cmp.setup(options)
    end,
  },
}
