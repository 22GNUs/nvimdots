local ensure_installed = {
  -- lua stuff
  "lua-language-server",
  -- go
  "gopls",
  -- shell
  "shellcheck",
  -- json
  "json-lsp",
}
local ui = require("ui.icons").ui

return {
  {
    "williamboman/mason.nvim",
    name = "mason",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
      ensure_installed = ensure_installed,
      PATH = "prepend",
      ui = {
        icons = {
          package_pending = ui.package_pending,
          package_installed = ui.package_installed,
          package_uninstalled = ui.package_uninstalled,
        },
        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      },
      max_concurrent_installers = 10,
    },
    config = function(self, opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
      require(self.name).setup(opts)
    end,
  },
}
