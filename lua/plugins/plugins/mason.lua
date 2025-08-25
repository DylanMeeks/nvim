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
				"tombi",
				"gersemi",
				"emmylua_ls",
				"emmylua-codeformat",
				"latexindent",
				"tex-fmt",
				"yq",
				"doctoc",
			}

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
				cmake = { "gersemi" },
				cpp = { "clang-format" },
				go = function(bufnr)
					return { first(bufnr, "goimports", "gofmt") }
				end,
				lua = { "stylua" },
				markdown = function(bufnr)
					return { first(bufnr, "marksman", "cbfmt") }
				end,
				ocaml = { "ocamlformat" },
				python = { "ruff", "black" },
				sh = { "beautysh" },
				toml = { "tombi" },
				yaml = { "yq" },
				tex = { "latexindent", "tex-fmt" },
				zig = { "zigfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
