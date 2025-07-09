return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {},
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup({
				ensure_install = {
					"core",
					"stable",
					"lua",
				},
			})
		end,
	},
}
