return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",

			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-smart-history.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"kkharji/sqlite.lua",
		},
		config = function()
			require("plugins.telescope")
		end,
	},
}
