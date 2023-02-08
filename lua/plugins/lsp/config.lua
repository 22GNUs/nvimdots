local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  require("core.utils").bind_mappings("lspconfig", bufopts)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

return {
  on_attach = on_attach,
  capabilities = capabilities,
  -- lsp servers
  servers = { "gopls", "jdtls" },
  -- mason ensure_installed
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    -- go
    "gopls",
    -- shell
    "shellcheck",
    -- json
    "json-lsp",
  },
  -- null-ls sources
  sources = function(b)
    return {
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

      -- Java
      b.formatting.google_java_format,
    }
  end,
}
