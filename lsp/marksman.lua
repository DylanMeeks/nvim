---@type vim.lsp.Config
return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "marksman", "server" },
	filetypes = { "markdown", "markdown.mdx" },
}
