---@diagnostic disable: undefined-global

return {
	-- Functions
	s({ trig = "f", wordTrig = true }, {
		t("func "),
		i(1),
		t("("),
		i(2),
		t(") "),
		i(3),
		t({ " {", "\t" }),
		i(4),
		t({ "", "}" }),
	}),
	s({ trig = "l", wordTrig = true }, {
		t("func "),
		t("() "),
		i(1),
		t({ " {", "\t" }),
		i(2),
		t({ "", "}()" }),
	}),

	-- Methods
	s({ trig = "m", wordTrig = true }, {
		t("func "),
		t("("),
		i(1),
		t(") "),
		i(2),
		t("("),
		i(3),
		t(") "),
		i(4),
		t({ " {", "\t" }),
		i(5),
		t({ "", "}" }),
	}),

	-- Structs
	s({ trig = "s", wordTrig = true }, {
		t("type "),
		i(1),
		t(" struct"),
		t({ " {", "\t" }),
		i(2),
		t({ "", "}" }),
	}),

	-- Interfaces
	s({ trig = "i", wordTrig = true }, {
		t("type "),
		i(1),
		t(" interface"),
		t({ " {", "\t" }),
		i(2),
		t("() "),
		i(3),
		t({ "", "}" }),
	}),
}
