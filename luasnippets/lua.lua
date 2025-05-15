local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- snippets
ls.add_snippets("lua", {

	s({ trig = "print", name = "print", dscr = "print something" }, {
		t('print("'),
		i(1, "desrc"),
		t(': " .. '),
		i(2, "the_variable"),
		t(")"),
	}),

	-- s("fn basic", {
	-- 	t("-- @param: "),
	-- 	f(utils.copy, 2),
	-- 	t({ "", "local " }),
	-- 	i(1),
	-- 	t(" = function("),
	-- 	i(2, "fn param"),
	-- 	t({ ")", "\t" }),
	-- 	i(0), -- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
	-- 	t({ "", "end" }),
	-- }),

	-- s("fn module", {
	-- 	-- make new line into snippet
	-- 	t("-- @param: "),
	-- 	f(utils.copy, 3),
	-- 	t({ "", "" }),
	-- 	i(1, "modname"),
	-- 	t("."),
	-- 	i(2, "fnname"),
	-- 	t(" = function("),
	-- 	i(3, "fn param"),
	-- 	t({ ")", "\t" }),
	-- 	i(0), -- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
	-- 	t({ "", "end" }),
	-- }),

	-------------------------------------
	---       lua function call       ---
	-------------------------------------

	-- dynamic extensible params
	-- table

	------------------------------
	---       lua tables       ---
	------------------------------
	-- key value pairs
	-- named sub tables
	--

	--------------------------------
	---       conditionals       ---
	--------------------------------
	-- if nil
	-- elseif

	s({ trig = "if basic", wordTrig = true }, {
		t({ "if " }),
		i(1),
		t({ " then", "\t" }),
		i(0),
		t({ "", "end" }),
	}),

	s({ trig = "ee", wordTrig = true }, {
		t({ "else", "\t" }),
		i(0),
	}),

	-- LOOPS ----------------------------------------

	s("for", {
		t("for "),
		c(1, {
			sn(
				nil,
				{ i(1, "k"), t(", "), i(2, "v"), t(" in "), c(3, { t("pairs"), t("ipairs") }), t("("), i(4), t(")") }
			),
			sn(nil, { i(1, "i"), t(" = "), i(2), t(", "), i(3) }),
		}),
		t({ " do", "\t" }),
		i(0),
		t({ "", "end" }),
	}),
})
