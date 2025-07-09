return {
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local trouble = require("trouble")
			trouble.setup()

			vim.keymap.set(
				"n",
				"<leader>tt",
				"<cmd>Trouble diagnostics toggle<cr>",
				{ silent = true, noremap = true, desc = "Toggle Trouble diagnostics" }
			)
			vim.keymap.set(
				"n",
				"<leader>tT",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				{ silent = true, noremap = true, desc = "Toggle buffer Trouble diagnostics" }
			)
			vim.keymap.set(
				"n",
				"<leader>tq",
				"<cmd>Trouble qflist toggle<cr>",
				{ silent = true, noremap = true, desc = "Toggle Trouble qflist" }
			)
			vim.keymap.set(
				"n",
				"<leader>tl",
				"<cmd>Trouble lsp toggle<cr>",
				{ silent = true, noremap = true, desc = "Toggle Trouble Lsp" }
			)

			vim.keymap.set(
				"n",
				"[t",
				"<cmd>Trouble diagnostics prev skip_groups=true jump=true<cr>",
				{ silent = true, noremap = true }
			)

			vim.keymap.set(
				"n",
				"]t",
				"<cmd>Trouble diagnostics next skip_groups=true jump=true<cr>",
				{ silent = true, noremap = true }
			)
		end,
	},
}
