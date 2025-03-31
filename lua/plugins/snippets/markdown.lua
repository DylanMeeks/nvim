-- snippets for markdown
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local postfix = require("luasnip.extras.postfix").postfix

local get_visual = function(_, parent)
	return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
end

ls.add_snippets("markdown", {
	s(
		{ trig = "qe", name = "code", dscr = "code" },
		fmt(
			[[
    ```<>
    <>
    ```]],
			{ i(1, "text"), i(0) },
			{ delimiters = "<>" }
		)
	),
	autosnippet(
		{ trig = "qw", name = "trig", dscr = "code" },
		fmt(
			[[
    `<>`<>
    ]],
			{ i(1), i(0) },
			{ delimiters = "<>" }
		)
	),
	autosnippet(
		{ trig = "!-", name = "checkbox bp", dscr = "checkbox bullet point" },
		fmt(
			[[
    - [<>] <>
    ]],
			{ c(1, { t(" "), t("x") }), i(0) },
			{ delimiters = "<>" }
		)
	),
	autosnippet(
		{ trig = "!l", name = "link", dscr = "link" },
		fmta(
			[[
    [<>](<>)
    ]],
			{ d(1, get_visual), i(0) }
		)
	),
	autosnippet(
		{ trig = "dm", name = "math 2", dscr = "display math" },
		fmt(
			[[
    $$<>$$<>
    ]],
			{ i(1), i(0) },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "sdoc", name = "trig", dscr = "dscr" },
		fmta(
			[[
    ## <>

    - <>

    ### Reflection
    <>
    ]],
			{ os.date("%d-%m-%Y"), i(1), i(0) }
		)
	),
	s({ trig = "mk", name = "math", dscr = "inline math" }, fmt([[$<>$<>]], { i(1), i(0) }, { delimiters = "<>" })),
	-- s({ trig='dm', name='math 2', dscr='display math'},
	-- fmt([[$$<>$$]],
	-- { i(1), i(0) },
	-- { delimiters='<>' }
	-- )),
	postfix("vc", { l("`" .. l.POSTFIX_MATCH .. "`") }),
	postfix("vr", { l("$" .. l.POSTFIX_MATCH .. "$") }),
})
