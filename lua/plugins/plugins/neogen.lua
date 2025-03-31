return {
	{
		"danymat/neogen",
		-- Uncomment next line if you want to follow only stable versions
		version = "*",
		config = function()
			local neogen = require("neogen")
			neogen.setup({ snippet_engine = "luasnip" })
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<Leader>nf", function()
				require("neogen").generate({ type = "func" })
			end, opts)
			vim.keymap.set("n", "<Leader>nc", function()
				require("neogen").generate({ type = "class" })
			end, opts)
			vim.keymap.set("n", "<Leader>nt", function()
				require("neogen").generate({ type = "type" })
			end, opts)
		end,
	},
}
