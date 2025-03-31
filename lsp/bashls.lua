---@type vim.lsp.Config
return {
  cmd = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' },
  settings = {
  }
}
