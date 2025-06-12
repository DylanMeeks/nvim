return {
	-- {
	-- 	"ramojus/mellifluous.nvim",
	-- 	-- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
	-- 	config = function()
	-- 		require("mellifluous").setup({
	-- 			styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
	-- 				main_keywords = { italic = true },
	-- 				comments = { italic = true },
	-- 			},
	--             transparent_background = { enabled = true }
	-- 		}) -- optional, see configuration section.
	-- 		vim.cmd("colorscheme mellifluous")
	-- 		vim.cmd("Mellifluous kanagawa_dragon")
	-- 	end,
	-- },
	-- {
	-- 	"zenbones-theme/zenbones.nvim",
	-- 	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- 	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- 	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	-- 	dependencies = "rktjmp/lush.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	-- you can set set configuration options here
	-- 	config = function()
	-- 		vim.g.zenbones_transparent_background = true
	-- 		-- vim.cmd.colorscheme('zenbones')
	-- 	end,
	-- },
	-- {
	-- 	"uZer/pywal16.nvim",
	-- 	   config = function()
	-- 	   	vim.cmd.colorscheme("pywal16")
	-- 	   end,
	-- },

	{
		"norcalli/nvim-colorizer.lua",
		name = "nvim-colorizer",
        enabled = false,
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa-dragon",
		config = function()
			require("kanagawa").setup({
				compile = true,
				keywordStyle = { italic = false },
				transparent = true, -- set background color
				overrides = function(colors) -- add/modify highlights
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

						TelescopeTitle = { fg = theme.ui.special, bold = true },
						TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
						TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
						TelescopePreviewNormal = { bg = theme.ui.bg_dim },
						TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

						-- uniform colors for pop-up menu
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
					}
				end,
				theme = "dragon",
				background = { -- map the value of 'background' option to a theme
					dark = "dragon",
					light = "lotus",
				},
			})

			-- vim.cmd("colorscheme kanagawa")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				italic = {
					strings = false,
				},
				contrast = "hard", -- can be "hard", "soft" or empty string
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"blazkowolf/gruber-darker.nvim",
		opts = {
			-- defaults
			bold = true,
			invert = {
				signs = false,
				tabline = false,
				visual = false,
			},
			italic = {
				strings = true,
				comments = true,
				operators = false,
				folds = true,
			},
			undercurl = true,
			underline = true,
		},
	},
	{
		"folke/tokyonight.nvim",
        enabled = false,
		opts = {},
	},
}
