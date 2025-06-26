return {
	"tpope/vim-fugitive",
	cmd = "Git",

	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "gitcommit",
			callback = function()
				vim.keymap.set("i", "<CR>", function()
					vim.cmd.x()
				end, { buffer = true })
			end,
		})
	end,
}
