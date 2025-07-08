return {
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
        config = function ()
            require("quicker").setup()
        end,
	},
}
