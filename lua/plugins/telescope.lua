local data = assert(vim.fn.stdpath("data")) --[[@as string]]
-- local actions = require("telescope.actions")
-- local open_with_trouble = require("trouble.sources.telescope").open

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "dune.lock" },
	},
	extensions = {
		wrap_results = true,
		fzf = {},
		history = {
			path = vim.fs.joinpath(data, "databases/telescope_history.sqlite3"),
			limit = 100,
		},
		media_files = {
			find_cmd = "rg",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>tf", builtin.find_files)
vim.keymap.set("n", "<leader>tg", builtin.git_files)
vim.keymap.set("n", "<leader>th", builtin.help_tags)
vim.keymap.set("n", "<leader>tr", require("plugins.telescope.multi-ripgrep"))
vim.keymap.set("n", "<leader>tb", builtin.buffers)
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>ts", builtin.grep_string)

vim.keymap.set("n", "<leader>fa", function()
	---@diagnostic disable-next-line: param-type-mismatch
	builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end)

vim.keymap.set("n", "<leader>en", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)
