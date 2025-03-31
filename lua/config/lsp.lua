-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		local builtin = require("telescope.builtin")

		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
		vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = 0 })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
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
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
					end
				end
			end)
		end, { desc = "Format code" })
	end,
})

vim.diagnostic.config({
	virtual_text = { current_line = true },
})

-- This is copied straight from blink
-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Setup language servers.
vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})

-- Enable each language server by filename under the lsp/ folder
vim.lsp.enable({
	"bashls",
	"luals",
	"clangd",
	"ocamllsp",
	"pyright",
	"ruff",
	"zls",
	"autotools_ls",
	"gopls",
})
