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
    "epwalsh/obsidian.nvim",
    ft = "markdown",
    cond = function()
      vim.pretty_print(vim.inspect())
      -- only load when edit markdown and in vault dir
      return vim.fn.getcwd():find("^" .. conf.ob.vault_dir) ~= nil
    end,
    dependencies = { "nvim-cmp", "telescope.nvim" },
    opts = {
      dir = conf.ob.vault_dir,
      completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
      },
      daily_notes = {
        folder = conf.ob.daily_path,
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      require("core.utils").bind_mappings_direct(conf.ob.keymaps)
    end,
  },
}
