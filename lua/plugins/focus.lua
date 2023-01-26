return {
  "beauwilliams/focus.nvim",
  name = "focus",
  keys = require("core.keymaps").focus,
  config = function(self)
    require(self.name).setup()
  end,
}
