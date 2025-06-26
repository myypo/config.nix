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
	s({ trig = "pf", wordTrig = true }, {
		t("export const "),
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
	s({ trig = "paf", wordTrig = true }, {
		t("export const "),
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
	s({ trig = "al", wordTrig = true }, {
		t("async ("),
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
	s({ trig = "ps", wordTrig = true }, {
		t("export type "),
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
	s({ trig = "pi", wordTrig = true }, {
		t("export interface "),
		i(1),
		t({ " {", "\t" }),
		i(2),
		t({ "", "}" }),
	}),
}
