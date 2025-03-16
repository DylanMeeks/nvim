local filetype = require("vim.filetype")
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{
				"folke/lazydev.nvim",
				ft = "lua",
			},
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

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

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {

				-- This seems to be unmaintained and fails pip install
				-- hdl_checker = true,

				-- Markdown
				marksman = true,
				-- doctoc = true,

				-- Bash
				bashls = true,
				-- beautysh = true,
				-- cbfmt = true,

				-- Neomutt language server
				-- mutt_ls = true,

				-- Makefiles
				-- checkmake = true,
				autotools_ls = true,

				-- zig language server
				-- zls = true,

				-- Go
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},

				-- Lua
				lua_ls = {
					server_capabilities = {
						semanticTokensProvider = vim.NIL,
					},
				},

				-- rust_analyzer = true,

				-- Python and mojo
				pyright = true,
				ruff = true,
				-- mojo = { manual_install = true },

				--[[
                -- TOML and YAML
				taplo = true,
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							-- schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
                --]]

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

					-- TODO: Check if i still need the filtypes stuff i had before
				},
                --]]

				clangd = {
					-- cmd = { "clangd", unpack(require("custom.clangd").flags) },
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },

					filetypes = { "c" },
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()

			local ensure_installed = {
				"stylua",
				"beautysh",
				"lua_ls",
				-- "delve",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			vim.list_extend(ensure_installed, {"zls@0.13.0"})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

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

			-- Autoformatting Setup
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					sh = { "beautysh" },
					-- blade = { "blade-formatter" },
					markdown = function(bufnr)
						return { first(bufnr, "marksman", "cbfmt", "doctoc") }
					end,
				},
			})

			conform.formatters.injected = {
				options = {
					ignore_errors = false,
					lang_to_formatters = {
						sql = { "sleek" },
					},
				},
			}

			-- This is autoformat on write
			--[[
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function(args)
                    -- local filename = vim.fn.expand "%:p"

                    local extension = vim.fn.expand("%:e")
                    if extension == "mlx" then
                        return
                    end

                    require("conform").format({
                        bufnr = args.buf,
                        lsp_fallback = true,
                        quiet = true,
                    })
                end,
            })
            --]]

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

					vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, { buffer = 0 })
					vim.keymap.set("n", "<leader>lds", builtin.lsp_document_symbols, { buffer = 0 })
					vim.keymap.set("n", "<leader>bf", function()
						-- local filename = vim.fn.expand "%:p"

						local extension = vim.fn.expand("%:e")
						if extension == "mlx" then
							return
						end

						require("conform").format({ async = true }, function(err)
							if not err then
								local mode = vim.api.nvim_get_mode().mode
								if vim.startswith(string.lower(mode), "v") then
									vim.api.nvim_feedkeys(
										vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
										"n",
										true
									)
								end
							end
						end)
					end, { desc = "Format code" })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

			vim.keymap.set("", "<leader>ll", function()
				local config = vim.diagnostic.config() or {}
				if config.virtual_text then
					vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				else
					vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				end
			end, { desc = "Toggle lsp_lines" })
		end,
	},
}
