---@type vim.lsp.Config
return {
	--cmd = { 'lua-language-server' },
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			completion = {
				callSnippet = "Disable",
				keywordSnippet = "Disable",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
		server_capabilities = {
			semanticTokensProvider = vim.NIL,
		},
	},
}
