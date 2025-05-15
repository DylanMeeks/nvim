local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local make_condition = require("luasnip.extras.conditions").make_condition

-- snippets
ls.add_snippets("go", {
	s({ trig = "iferr", name = "if err != nil", desc = "go error handling" }, {
		fmta(
            [[
            if err != nil {
                return <>
            }
            ]],
			{ i(i, "err") }
		),
	}),
})
