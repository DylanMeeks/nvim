return {
	--[[
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local lualine = require("lualine")

            --lualine.setup {
            --  options = {
            --    theme = "catppuccin-mocha"
            --  }
            --}

            -- Eviline config for lualine
            -- Author: shadmansaleh
            -- Credit: glepnir

            -- Color table for highlights
            -- stylua: ignore
            local colors = {
                bg       = '#282828',
                fg       = '#ebdbb2',
                yellow   = '#d79921',
                cyan     = '#83a598',
                darkblue = '#458588',
                green    = '#98971a',
                orange   = '#d65d0e',
                violet   = '#b16286',
                magenta  = '#d3869b',
                blue     = '#83a598',
                red      = '#cc241d',
            }

			local dragon_colors = require("kanagawa.colors").setup({ theme = "dragon" })

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config
			local config = {
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					theme = {
						-- We are going to use lualine_c an lualine_x as left and
						-- right section. Both are highlighted by c theme .  So we
						-- are just setting default looks o statusline
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x at right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				"filesize",
				cond = conditions.buffer_not_empty,
			})

			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.magenta },
			})

			ins_left({ "location" })

			ins_left({ "progress", color = { fg = colors.fg } })

			-- ins_left({
			--     'diagnostics',
			--     sources = { 'nvim_diagnostic' },
			--     symbols = { error = 'E ', warn = 'W ', info = 'I ' },
			--     diagnostics_color = {
			--         color_error = { fg = colors.red },
			--         color_warn = { fg = colors.yellow },
			--         color_info = { fg = colors.cyan },
			--     },
			-- })

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2

			ins_left({
				function()
					return "%="
				end,
			})

			ins_left({
				-- Lsp server name .
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = "| LSP:",
				color = { fg = "#ffffff", gui = "bold" },
			})

			-- Add components to right sections
			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"branch",
				icon = "|",
				color = { fg = colors.violet, gui = "bold" },
			})

			ins_right({
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = "+ ", modified = "~ ", removed = "- " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})

			-- Now don't forget to initialize lualine
			lualine.setup(config)
		end,
	},
    --]]
	{
		"tjdevries/express_line.nvim",
		config = function()
			require("plugins.statusline").setup()
		end,
	},
}
