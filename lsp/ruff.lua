---@type vim.lsp.Config
return {
  cmd = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml' },
  settings = {
  },
}
