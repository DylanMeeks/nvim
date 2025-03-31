return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{
				"folke/lazydev.nvim",
				ft = "lua",
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
            "stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			require("lazydev").setup({
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			})

			local servers = {

				--[[
				ocamllsp = {
					manual_install = true,
					cmd = { "dune", "exec", "ocamllsp" },
					settings = {
						codelens = { enable = true },
						inlayHints = { enable = true },
						syntaxDocumentation = { enable = true },
					},

					get_language_id = function(_, lang)
						print("LANG:", lang)
						local map = {
							["ocaml.mlx"] = "ocaml",
						}
						return map[lang] or lang
					end,

					filetypes = {
						"ocaml",
						"ocaml.interface",
						"ocaml.menhir",
						"ocaml.cram",
						"ocaml.mlx",
						"ocaml.ocamllex",
						"reason",
					},

					server_capabilities = {
						semanticTokensProvider = false,
					},

				},
                --]]
			}

			require("mason").setup()

			local ensure_installed = {
				"bashls",
                "beautysh",
                "lua_ls",
				"stylua",
                "clangd",
                "ocaml-lsp",
                "pyright",
                "ruff",
                "zls",
				"autotools_ls",
                "gopls",
                "marksman",
                "cbfmt",
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
					markdown = function(bufnr)
						return { first(bufnr, "marksman", "cbfmt") }
					end,
                    python = { "ruff" },
				},
			})

		end,
	},
}
