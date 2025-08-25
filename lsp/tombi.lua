---@type vim.lsp.Config
return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "tombi" },
	filetypes = { "toml" },
	root_markers = { "tombi.toml", "pyproject.toml", ".git" },
	settings = {},
}
