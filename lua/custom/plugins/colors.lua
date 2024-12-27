function ColorMyPencils(color)
	color = color or "kanagawa-dragon"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"ramojus/mellifluous.nvim",
		-- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
		config = function()
			require("mellifluous").setup({
				styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
					main_keywords = { italic = true },
                    comments = { italic = true },
				},
			}) -- optional, see configuration section.
			vim.cmd("colorscheme mellifluous")
            vim.cmd("Mellifluous kanagawa_dragon")
		end,
	},
	--[[
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa-dragon",
		config = function()
			require("kanagawa").setup({
				undercurl = true, -- enable undercurls
				commentStyle = { italic = false },
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

			ColorMyPencils()
		end,
	},
    --]]
	--[[
    {
        "EdenEast/nightfox.nvim",
        name  = "nightfox",
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = true,
                },
            })
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = fuction()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = {     -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = true,
                term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
            })
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = fuction()
            require("gruvbox").setup({})
        end,
    },
    --]]
}
