local data = assert(vim.fn.stdpath("data")) --[[@as string]]

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "dune.lock" },
		preview = false, -- this is broken for me for some reason
		-- border = {
		-- 	prompt = { 1, 1, 1, 1 },
		-- 	results = { 1, 1, 1, 1 },
		-- 	preview = { 1, 1, 1, 1 },
		-- },
		-- borderchars = {
		-- 	prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
		-- 	results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
		-- 	preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
		-- },
	},
	extensions = {
		wrap_results = true,

		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",
		},
		history = {
			path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
			limit = 100,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
		theme = "ivy",
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<space>fd", builtin.find_files, { desc = "Telescope find files", silent = true })
vim.keymap.set("n", "<space>ft", function()
	return builtin.git_files({ cwd = vim.fn.expand("%:h") })
end, { desc = "Telescope find git files", silent = true })
vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = "Telescope search Vim docs", silent = true })
vim.keymap.set(
	"n",
	"<space>fg",
	require("plugins.telescope.multi-ripgrep"),
	{ desc = "Telescope multi-ripgrep", silent = true }
)
vim.keymap.set("n", "<space>fb", builtin.buffers, { desc = "Telescope find buffers", silent = true })
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = "Telescope search buffer", silent = true })

vim.keymap.set("n", "<space>gw", builtin.grep_string, { desc = "Telescope grep string", silent = true })

vim.keymap.set("n", "<space>fa", function()
	---@diagnostic disable-next-line: param-type-mismatch
	builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end, { desc = "Telescope find lazy plugins", silent = true })

vim.keymap.set("n", "<space>en", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Telescope find config", silent = true })
