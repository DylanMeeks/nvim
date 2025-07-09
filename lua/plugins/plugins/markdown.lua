return {
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			-- Viewer settings
			vim.g.vimtex_view_method = "zathura_simple" -- For Wayland compatibility, avoid xdotool
			vim.g.vimtex_context_pdf_viewer = "okular" -- External PDF viewer for the Vimtex menu

			-- Formatting settings
			-- vim.g.vimtex_format_enabled = true             -- Enable formatting with latexindent
			-- vim.g.vimtex_format_program = 'latexindent'

			-- Indentation settings
			vim.g.vimtex_indent_enabled = false -- Disable auto-indent from Vimtex
			vim.g.tex_indent_items = false -- Disable indent for enumerate
			vim.g.tex_indent_brace = false -- Disable brace indent

			-- Suppression settings
			vim.g.vimtex_quickfix_mode = 0 -- Suppress quickfix on save/build
			vim.g.vimtex_log_ignore = { -- Suppress specific log messages
				"Underfull",
				"Overfull",
				"specifier changed to",
				"Token not allowed in a PDF string",
			}

			-- Other settings
			vim.g.vimtex_mappings_enabled = false -- Disable default mappings
			vim.g.tex_flavor = "latex" -- Set file type for TeX files
		end,
		--[[
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>xb", "<cmd>VimtexCompile<CR>", { silent = true, desc = "build" })
			vim.keymap.set({ "n", "v" }, "<leader>xi", "<cmd>VimtexTocOpen<CR>", { silent = true, desc = "index" })
			vim.keymap.set({ "n", "v" }, "<leader>xv", "<cmd>VimtexView<CR>", { silent = true, desc = "view" })
			-- name = "ACTIONS",
			vim.keymap.set({ "n", "v" }, "a", "<cmd>lua PdfAnnots()<CR>", { silent = true, desc = "annotate" })
			vim.keymap.set(
				{ "n", "v" },
				"b",
				"<cmd>terminal bibexport -o %:p:r.bib %:p:r.aux<CR>",
				{ silent = true, desc = "bib export" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"c",
				"<cmd>:VimtexClearCache All<CR>",
				{ silent = true, desc = "clear vimtex" }
			)
			vim.keymap.set({ "n", "v" }, "e", "<cmd>VimtexErrors<CR>", { silent = true, desc = "error report" })
			vim.keymap.set({ "n", "v" }, "f", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true, desc = "format" })
			vim.keymap.set(
				{ "n", "v" },
				"g",
				"<cmd>e ~/.config/nvim/templates/Glossary.tex<CR>",
				{ silent = true, desc = "edit glossary" }
			)
			-- vim.keymap.set({"n", "v"}, "h", "<cmd>lua _HTOP_TOGGLE()<CR>", { silent = true, desc = "htop" })
			vim.keymap.set({ "n", "v" }, "h", "<cmd>LocalHighlightToggle<CR>", { silent = true, desc = "highlight" })
			vim.keymap.set({ "n", "v" }, "k", "<cmd>VimtexClean<CR>", { silent = true, desc = "kill aux" })
			vim.keymap.set({ "n", "v" }, "l", "<cmd>LeanInfoviewToggle<CR>", { silent = true, desc = "lean info" })
			-- vim.keymap.set({"n", "v"}, "l", "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>", { silent = true, desc = "LSP" })
			-- vim.keymap.set({"n", "v"}, "m", "<cmd>MarkdownPreview<CR>", { silent = true, desc = "markdown preview" })

			vim.keymap.set({ "n", "v" }, "r", "<cmd>AutolistRecalculate<CR>", { silent = true, desc = "reorder list" })
			vim.keymap.set(
				{ "n", "v" },
				"t",
				"<cmd>terminal latexindent -w %:p:r.tex<CR>",
				{ silent = true, desc = "tex format" }
			)
			vim.keymap.set({ "n", "v" }, "u", "<cmd>cd %:p:h<CR>", { silent = true, desc = "update cwd" })
			vim.keymap.set({ "n", "v" }, "v", "<plug>(vimtex-context-menu)", { silent = true, desc = "vimtex menu" })
			vim.keymap.set({ "n", "v" }, "w", "<cmd>VimtexCountWords!<CR>", { silent = true, desc = "word count" })
			-- vim.keymap.set({"n", "v"}, "w", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.docx'<CR>", { silent = true, desc = "word" })
			-- vim.keymap.set({"n", "v"}, "s", "<cmd>lua function() require('cmp_vimtex.search').search_menu() end<CR>", { silent = true, desc = "search citations" })
			vim.keymap.set(
				{ "n", "v" },
				"s",
				"<cmd>e ~/.config/nvim/snippets/tex.snippets<CR>",
				{ silent = true, desc = "snippets edit" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"S",
				"<cmd>TermExec cmd='ssh brastmck@eofe10.mit.edu'<CR>",
				{ silent = true, desc = "ssh" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"c",
				"<cmd>Telescope bibtex format_string=\\citet{%s}<CR>",
				{ silent = true, desc = "citations" }
			)
			-- MARKDOWN MAPPINGS
			-- name = "MARKDOWN",
			vim.keymap.set({ "n", "v" }, "v", "<cmd>Slides<CR>", { silent = true, desc = "view slides" })
			-- name = "PANDOC",
			vim.keymap.set(
				{ "n", "v" },
				"w",
				"<cmd>TermExec cmd='pandoc %:p -o %:p:r.docx'<CR>",
				{ silent = true, desc = "word" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"m",
				"<cmd>TermExec cmd='pandoc %:p -o %:p:r.md'<CR>",
				{ silent = true, desc = "markdown" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"h",
				"<cmd>TermExec cmd='pandoc %:p -o %:p:r.html'<CR>",
				{ silent = true, desc = "html" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"l",
				"<cmd>TermExec cmd='pandoc %:p -o %:p:r.tex'<CR>",
				{ silent = true, desc = "latex" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"p",
				"<cmd>TermExec cmd='pandoc %:p -o %:p:r.pdf' open=0<CR>",
				{ silent = true, desc = "pdf" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"v",
				"<cmd>TermExec cmd='zathura %:p:r.pdf &' open=0<CR>",
				{ silent = true, desc = "view" }
			)
			-- vim.keymap.set({"n", "v"}, "x", "", { silent = true, desc = "word to pdf" })
		end,
        --]]
	},
}
