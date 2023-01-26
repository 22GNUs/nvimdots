-- be sure to load options first
require("core.options")
require("gui")
-- bind general keymaps
require("core.utils").bind_mappings("general")
-- lazy load init
require("core.lazy").setup()
