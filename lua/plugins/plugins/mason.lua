return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",
		},
		config = function()
			require("mason").setup()

			local ensure_installed = {
				"bash-language-server",
				"beautysh",
				"lua-language-server",
				"stylua",
				"clangd",
				"clang-format",
				"ocaml-lsp",
				"ocamlformat",
				"pyright",
				"ruff",
				"black",
				"zls",
				"autotools-language-server",
				"gopls",
				"goimports",
				"marksman",
				"cbfmt",
				"taplo",
			}

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Run the first available formatter followed by more formatters
			---@param bufnr integer
			---@param ... string
			---@return string
			local function first(bufnr, ...)
				local conform = require("conform")
				for i = 1, select("#", ...) do
					local formatter = select(i, ...)
					if conform.get_formatter_info(formatter, bufnr).available then
						return formatter
					end
				end
				return select(1, ...)
			end

			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					sh = { "beautysh" },
					zig = { "zigfmt" },
					ocaml = { "ocamlformat" },
					markdown = function(bufnr)
						return { first(bufnr, "marksman", "cbfmt") }
					end,
					python = { "ruff", "black" },
					go = { "goimports", "gofmt" },
					c = { "clang-format" },
                    cpp = { "clang-format" },
				},
			})
		end,
	},
}
