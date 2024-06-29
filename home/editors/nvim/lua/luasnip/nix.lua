---@diagnostic disable: undefined-global
return {
	s({ trig = "let", wordTrig = true }, {
		t({ "let", "\t" }),
		i(1),
		t({ "\t", "in" }),
		i(2),
	}),

	s({ trig = "if", wordTrig = true }, {
		t("if "),
		i(1),
		t({ " then", "\t" }),
		i(2),
		t({ "\t", "else " }),
		i(3),
	}),
}
