---@diagnostic disable: undefined-global

return {
	-- Functions
	s({ trig = "f", wordTrig = true }, {
		t("const "),
		i(1),
		t(" = ("),
		i(2),
		t(") => "),
		i(3),
	}),
	s({ trig = "af", wordTrig = true }, {
		t("const "),
		i(1),
		t(" = async ("),
		i(2),
		t(") => "),
		i(3),
	}),
	s({ trig = "l", wordTrig = true }, {
		t("("),
		i(1),
		t(") => "),
		i(2),
	}),

	-- Structs (types)
	s({ trig = "s", wordTrig = true }, {
		t("type "),
		i(1),
		t(" ="),
		t({ " {", "\t" }),
		i(2),
		t({ "", "}" }),
	}),

	-- Interfaces
	s({ trig = "i", wordTrig = true }, {
		t("interface "),
		i(1),
		t({ " {", "\t" }),
		i(2),
		t({ "", "}" }),
	}),
}
