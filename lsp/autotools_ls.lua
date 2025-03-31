---@type vim.lsp.Config
return {
  cmd = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'autotools-language-server' },
  filetypes = { 'configure.ac', 'Makefile', 'Makefile.am', '.mk' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  settings = {
  }
}
