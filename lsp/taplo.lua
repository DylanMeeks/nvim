---@type vim.lsp.Config
return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "taplo" },
	filetypes = { "toml" },
	root_markers = {},
	settings = {},
}
