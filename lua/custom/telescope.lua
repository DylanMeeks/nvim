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
			--path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
			limit = 100,
		},
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			-- filetypes = { "png", "webp", "jpg", "jpeg" },
			-- find command (defaults to `fd`)
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
pcall(require("telescope").load_extension, "media_files")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<space>fd", builtin.find_files)
vim.keymap.set("n", "<space>ft", builtin.git_files)
vim.keymap.set("n", "<space>fh", builtin.help_tags)
vim.keymap.set("n", "<space>fg", require("custom.telescope.multi-ripgrep"))
vim.keymap.set("n", "<space>fb", builtin.buffers)
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<space>gw", builtin.grep_string)

vim.keymap.set("n", "<space>fa", function()
	---@diagnostic disable-next-line: param-type-mismatch
	builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end)

vim.keymap.set("n", "<space>en", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)

vim.keymap.set("n", "<space>eo", function()
	builtin.find_files({ cwd = "~/.config/nvim-backup/" })
end)

vim.keymap.set("n", "<space>fp", function()
	builtin.find_files({ cwd = "~/plugins/" })
end)
