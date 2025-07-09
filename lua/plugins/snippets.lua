local ls = require("luasnip")

-- TODO: Think about `locally_jumpable`, etc.
-- Might be nice to send PR to luasnip to use filters instead for these functions ;)

vim.snippet.expand = ls.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
	filter = filter or {}
	filter.direction = filter.direction or 1

	if filter.direction == 1 then
		return ls.expand_or_jumpable()
	else
		return ls.jumpable(filter.direction)
	end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
	if direction == 1 then
		if ls.expandable() then
			return ls.expand_or_jump()
		else
			return ls.jumpable(1) and ls.jump(1)
		end
	else
		return ls.jumpable(-1) and ls.jump(-1)
	end
end

vim.snippet.stop = ls.unlink_current

-- ================================================
--      My Configuration
-- ================================================
local extras = require("luasnip.extras")
ls.setup({
	history = true,
	updateevents = { "TextChanged", "TextChangedI" },
	override_builtin = true,
	snip_env = {
		ls = require("luasnip"),
		s = ls.snippet,
		sn = ls.snippet_node,
		isn = ls.indent_snippet_node,
		t = ls.text_node,
		i = ls.insert_node,
		f = ls.function_node,
		c = ls.choice_node,
		d = ls.dynamic_node,
		r = ls.restore_node,
		events = require("luasnip.util.events"),
		ai = require("luasnip.nodes.absolute_indexer"),
		extras = require("luasnip.extras"),
		l = extras.lambda,
		rep = extras.rep,
		p = extras.partial,
		m = extras.match,
		n = extras.nonempty,
		dl = extras.dynamic_lambda,
		fmt = require("luasnip.extras.fmt").fmt,
		fmta = require("luasnip.extras.fmt").fmta,
		conds = require("luasnip.extras.expand_conditions"),
		postfix = require("luasnip.extras.postfix").postfix,
		types = require("luasnip.util.types"),
		parse = require("luasnip.util.parser").parse_snippet,
		ms = ls.multi_snippet,
		k = require("luasnip.nodes.key_indexer").new_key,
	},
	keys = function()
		-- Disable default tab keybinding in LuaSnip
		return {}
	end,
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("luasnippets/*.lua", true)) do
	loadfile(ft_path)()
end

-- require("luasnip.loaders.from_lua").lazy_load({ lazy_paths = vim.api.nvim_get_runtime_file("luasnippets/*.lua", true) })
-- require("luasnip.loaders.from_lua").load({ paths = vim.api.nvim_get_runtime_file("luasnippets/*.lua", true)})

vim.keymap.set({ "i", "s" }, "<C-h>", function()
	return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true, desc = "Go to previous snippet input" })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true, desc = "Go to next snippet input" })

vim.keymap.set({ "i", "s" }, "<C-e>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true, desc = "Toggle between snippet choices" })
