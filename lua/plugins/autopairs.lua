return {
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
}
