return {
  {
    "rafamadriz/friendly-snippets",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "friendly-snippets", "nvim-cmp" },
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
  { "saadparwaiz1/cmp_luasnip", dependencies = "LuaSnip" },
  { "hrsh7th/cmp-nvim-lua", dependencies = "cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp", dependencies = "cmp-nvim-lua" },
  { "hrsh7th/cmp-buffer", dependencies = "cmp-nvim-lsp" },
  { "hrsh7th/cmp-path", dependencies = "cmp-buffer", event = "InsertEnter" },
}
