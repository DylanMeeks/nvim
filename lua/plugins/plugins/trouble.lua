return {
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local trouble = require("trouble")
			trouble.setup()

			vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>tl", "<cmd>Trouble lsp toggle<cr>", { silent = true, noremap = true })

			vim.keymap.set(
				"n",
				"[t",
				"<cmd>Trouble diagnostics next skip_groups=true jump=true<cr>",
				{ silent = true, noremap = true }
			)

			vim.keymap.set(
				"n",
				"]t",
				"<cmd>Trouble diagnostics prev skip_groups=true jump=true<cr>",
				{ silent = true, noremap = true }
			)
		end,
	},
}
