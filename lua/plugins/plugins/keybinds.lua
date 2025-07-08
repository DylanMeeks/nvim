return {
	{
		"tris203/hawtkeys.nvim",
        enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = {
			-- an empty table will work for default config
			--- if you use functions, or whichkey, or lazy to map keys
			--- then please see the API below for options
			customMaps = {
				--- EG local map = vim.api
				--- map.nvim_set_keymap('n', '<leader>1', '<cmd>echo 1')
				--- {
				--- 	["map.nvim_set_keymap"] = { --name of the expression
				--- 		modeIndex = "1", -- the position of the mode setting
				--- 		lhsIndex = "2", -- the position of the lhs setting
				--- 		rhsIndex = "3", -- the position of the rhs setting
				--- 		optsIndex = "4", -- the position of the index table
				--- 		method = "dot_index_expression", -- if the function name contains a dot
				--- 	},
				--- },
				--- --- EG local map2 = vim.api.nvim_set_keymap
				--- ["map2"] = { --name of the function
				--- 	modeIndex = 1, --if you use a custom function with a fixed value, eg normRemap, then this can be a fixed mode eg 'n'
				--- 	lhsIndex = 2,
				--- 	rhsIndex = 3,
				--- 	optsIndex = 4,
				--- 	method = "function_call",
				--- },
				-- If you use lazy.nvim's keys property to configure keymaps in your plugins
				["lazy"] = {
					method = "lazy",
				},
			},
		},
	},
}
