return {
	"codethread/qmk.nvim",
	ft = "dts",

	config = function()
		require("qmk").setup({
			name = "glove80",
			variant = "zmk",
			layout = {
				-- Comments for the stock QWERTY layout orientation
				"x x x x x _ _ _ _ _ _ _ _ _ x x x x x", -- F1..=F10
				"x x x x x x _ _ _ _ _ _ _ x x x x x x", -- Numbers
				"x x x x x x _ _ _ _ _ _ _ x x x x x x", -- QWERTY
				"x x x x x x _ _ _ _ _ _ _ x x x x x x", -- ASDFG
				"x x x x x x x x x _ x x x x x x x x x", -- ZXCDB
				"x x x x x _ x x x _ x x x _ x x x x x", -- Arrows
			},
		})
	end,
}
