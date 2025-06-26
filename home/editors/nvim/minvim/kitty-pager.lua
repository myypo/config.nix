return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
	local term_buf = vim.api.nvim_create_buf(true, false)
	local term_io = vim.api.nvim_open_term(term_buf, {})
	vim.api.nvim_buf_set_keymap(term_buf, "n", "q", "<Cmd>q<CR>", {})
	local group = vim.api.nvim_create_augroup("kitty-pager", {})

	vim.cmd([[autocmd VimEnter * silent! hi Normal guibg=NONE]])

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = group,
		buffer = term_buf,
		command = "stopinsert",
	})

	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		pattern = "*",
		once = true,
		callback = function(ev)
			local current_win = vim.fn.win_getid()
			for _, line in ipairs(vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)) do
				vim.api.nvim_chan_send(term_io, line)
				vim.api.nvim_chan_send(term_io, "\r\n")
			end
			term_io = false
			vim.api.nvim_win_set_buf(current_win, term_buf)
			vim.api.nvim_buf_delete(ev.buf, { force = true })
		end,
	})
end
