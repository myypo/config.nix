---@diagnostic disable: undefined-global
return {
	s({ trig = "feat", wordTrig = true }, {
		t({ "feat(" }),
		i(1),
		t({ "): " }),
		i(2),
	}),
	s({ trig = "fix", wordTrig = true }, {
		t({ "fix(" }),
		i(1),
		t({ "): " }),
		i(2),
	}),
	s({ trig = "hotfix", wordTrig = true }, {
		t({ "hotfix(" }),
		i(1),
		t({ "): " }),
		i(2),
	}),
	s({ trig = "docs", wordTrig = true }, {
		t({ "docs(" }),
		i(1),
		t({ "): " }),
		i(2),
	}),
	s({ trig = "chore", wordTrig = true }, {
		t({ "chore(" }),
		i(1),
		t({ "): " }),
		i(2),
	}),
	s({ trig = "perf", wordTrig = true }, {
		t({ "perf(" }),
		i(1),
		t({ "): " }),
		i(2),
	}),
	s({ trig = "refactor", wordTrig = true }, {
		t({ "refactor(" }),
		i(1),
		t({ "): " }),
		i(2),
	}),
}
