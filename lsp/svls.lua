---@type vim.lsp.Config
return {
	cmd = { "svls" },
	filetypes = { "systemverilog", "verilog" },
	root_markers = { ".svlint.toml", ".git" },
	settings = {},
}
