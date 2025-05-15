---@type vim.lsp.Config
return {
	cmd = {
		vim.fn.stdpath("data") .. "/mason/bin/" .. "clangd",
		"--background-index",
		"--clang-tidy",
		"--log=verbose",
		"--query-driver=**",
		"--completion-style=detailed",
		"--function-arg-placeholders",
        "--header-insertion=iwyu",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json", -- this needs bear
		"compile_flags.txt",
		"configure.ac", -- AutoTools
		".git",
	},
}
