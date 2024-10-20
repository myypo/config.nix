return {
	"ton/vim-bufsurf",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"<C-t>",
			"<Cmd>BufSurfBack<CR>",
		},
		{
			"<C-S-t>",
			"<Cmd>BufSurfForward<CR>",
		},
	},
}
