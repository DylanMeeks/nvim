return {
	{
		"ggandor/leap.nvim",
        enabled = false,
		config = function()
			require("leap").set_default_mappings()
		end,
	},
}
