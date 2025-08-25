vim.filetype.add({
	extension = {
		tpp = "cpp",
	},
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("CustomCppDetection", {}),
	desc = "Set .tpp files to C++",
	callback = function(ev)
		if vim.fn.expand("%"):sub(-4) == ".tpp" then
			vim.api.nvim_set_option_value("filetype", "cpp", { buf = ev.buf })
		end
	end,
})
