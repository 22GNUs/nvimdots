return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "plenary", "nvim-lspconfig" },
    config = function()
      local null_ls = require("null-ls")
      local b = null_ls.builtins
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local sources = {

        -- Lua
        b.formatting.stylua,
        b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

        -- Shell
        b.formatting.shfmt,
        b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

        -- Golang
        b.formatting.gofmt,

        -- Es
        b.formatting.eslint,
        b.diagnostics.eslint,
      }
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
