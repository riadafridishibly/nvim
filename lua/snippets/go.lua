local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

return {
	s("iferr", {
		t("if err != nil {"),
		t({ "", "\treturn " }),
		i(1, "nil, err"),
		t({ "", "}" }),
	}),
}
