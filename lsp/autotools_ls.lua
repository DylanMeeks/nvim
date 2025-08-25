---@type vim.lsp.Config
return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "autotools-language-server" },
	filetypes = { "config", "automake", "make" },
	root_markers = { "configure.ac", "Makefile", "Makefile.am", "*.mk" },
	settings = {},
}
