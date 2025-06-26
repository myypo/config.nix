return {
	"ton/vim-bufsurf",
	event = "BufReadPre",
	keys = {
		{ "<C-h>", "<Cmd>BufSurfBack<CR>" },
		{ "<C-,>", "<Cmd>BufSurfForward<CR>" },
	},
}
