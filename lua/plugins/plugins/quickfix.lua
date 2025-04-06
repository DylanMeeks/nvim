return {
	-- {
	-- 	"kevinhwang91/nvim-bqf",
	-- 	enabled = false,
	-- 	config = function()
	-- 		require("bqf").setup()
	-- 	end,
	-- },
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
