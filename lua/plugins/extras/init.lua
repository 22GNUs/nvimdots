-- some plugins that not usually used
local conf = {
  ob = {
    vault_dir = "/Users/wangxinhua/Library/Mobile Documents/iCloud~md~obsidian/Documents/BackToFuture",
    daily_path = "Daily",
    keymaps = {
      {
        "gf",
        function()
          local ok, obsidian = pcall(require, "obsidian")
          if ok and obsidian.util.cursor_on_markdown_link() then
            return ":ObsidianFollowLink <CR>"
          else
            return "gf"
          end
        end,
        desc = "obsidian follow link",
        expr = true,
      },
    },
  },
}
return {
  -- obsidian
  {
    "22GNUs/obsidian.nvim",
    event = require("core.lazy").event.VeryLazy,
    version = false,
    cond = function()
      -- only load when edit markdown and in vault dir
      return vim.fn.getcwd():find("^" .. conf.ob.vault_dir) ~= nil
    end,
    dependencies = { "nvim-cmp", "telescope.nvim" },
    opts = {
      dir = conf.ob.vault_dir,
      use_advanced_uri = true,
      completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
      },
      daily_notes = {
        folder = conf.ob.daily_path,
      },
      note_frontmatter_func = function(note)
        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
          title = note.path.filename:match("/([^/]+).md$"),
          date = os.time(),
        }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      require("core.utils").bind_mappings_direct(conf.ob.keymaps)
    end,
  },
}
