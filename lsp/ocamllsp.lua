return {
	--cmd = { 'lua-language-server' },
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "ocamllsp" },
	filetypes = {
		"ocaml",
		"ocaml.interface",
		"ocaml.menhir",
		"ocaml.cram",
		"ocaml.mlx",
		"ocaml.ocamllex",
		"reason",
        "dune",
	},
	settings = {
		codelens = { enable = true },
		inlayHints = { enable = true },
		syntaxDocumentation = { enable = true },
	},
	get_language_id = function(_, lang)
		print("LANG:", lang)
		local map = {
			["ocaml.mlx"] = "ocaml",
		}
		return map[lang] or lang
	end,
	server_capabilities = {
		semanticTokensProvider = false,
	},
}
