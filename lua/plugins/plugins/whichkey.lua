return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "classic",
			plugins = {
				marks = false,
				operators = false,
				windows = false,
				nav = false,
			},
			win = {
				padding = { 0, 1 },
				title = false,
				border = "none",
			},
			icons = {
				breadcrumb = ">>=",
				separator = ":: ",
				group = " ++ ",
				keys = {},
			},
			triggers = {
				{ "<leader>x", mode = { "n", "v" } }, -- only enable for Vimtex
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
