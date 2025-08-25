---@type vim.lsp.Config
return {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "emmylua_ls" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".emmyrc.json", ".luacheckrc", ".git" },
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}
