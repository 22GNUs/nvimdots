local ui = require("ui.icons").ui
local cfg = require("plugins.lsp.config")
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = require("core.lazy").event.BufReadPre,
    dependencies = { "plenary", "mason" },
    config = function()
      -- render lsp ui
      require("ui.lsp")
      local lspconfig = require("lspconfig")
      local on_attach = cfg.on_attach
      local capabilities = cfg.capabilities
      for _, lsp in ipairs(cfg.servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      lspconfig.sumneko_lua.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      })
    end,
  },
  -- mason
  {
    "williamboman/mason.nvim",
    name = "mason",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
      ensure_installed = cfg.ensure_installed,
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
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  -- null_ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "plenary", "nvim-lspconfig" },
    event = require("core.lazy").event.BufReadPre,
    config = function()
      local null_ls = require("null-ls")
      local b = null_ls.builtins
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local sources = cfg.sources(b)
      null_ls.setup({
        debug = true,
        sources = sources,

        -- format on save
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
}
