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
  servers = { "gopls" },
  on_attach = on_attach,
  capabilities = capabilities,
  insure_installed = {
    -- lua stuff
    "lua-language-server",
    -- go
    "gopls",
    -- shell
    "shellcheck",
    -- json
    "json-lsp",
  },
}
