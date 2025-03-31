---@type vim.lsp.Config
return {
  --cmd = { 'lua-language-server' },
  cmd = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    },
    server_capabilities = {
        semanticTokensProvider = vim.NIL,
    },
  }
}
