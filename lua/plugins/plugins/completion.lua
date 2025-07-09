return {
	{
		"saghen/blink.cmp",
		build = "cargo build --release",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"saghen/blink.compat",
				optional = true, -- make optional so it's only enabled if any extras need it
				opts = {},
				version = "*",
			},
			-- git source
			{
				"Kaiser-Yang/blink-cmp-git",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
			-- other git source
			{ "disrupted/blink-cmp-conventional-commits" },
			-- snippets
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				config = function()
					require("plugins.snippets")
				end,
			},
		},

		version = "1.*",

		opts = {
			keymap = {
				preset = "default",
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				ghost_text = {
					enabled = true,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "conventional_commits", "git", "lazydev", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					git = {
						module = "blink-cmp-git",
						name = "Git",
						opts = {
							-- options for the blink-cmp-git
						},
					},
					conventional_commits = {
						name = "Conventional Commits",
						module = "blink-cmp-conventional-commits",
						enabled = function()
							return vim.bo.filetype == "gitcommit"
						end,
						---@module 'blink-cmp-conventional-commits'
						---@type blink-cmp-conventional-commits.Options
						opts = {}, -- none so far
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			snippets = { preset = "luasnip" },
			signature = { enabled = true },
		},
	},
}
