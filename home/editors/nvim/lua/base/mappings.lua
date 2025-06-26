---@param mode string | string[]
---@param key string
---@param fun string | function
---@param opts? table<string, boolean>
Keymap = function(mode, key, fun, opts)
	vim.keymap.set(mode, key, fun, opts or { noremap = true, silent = true })
end

---@param mode string | string[]
---@param key string
local unmap = function(mode, key)
	vim.keymap.del(mode, key)
end

-- Remap space as Leader key
Keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "

----- NORMAL -----

-- Prevents cursor from moving when using J
Keymap("n", "J", "mzJ`z")

Keymap("n", "<Leader>s", ":w<CR>")

-- No dizziness when navigating
local function lazy_feedkeys(keys)
	keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	return function()
		local old = vim.o.lazyredraw
		vim.o.lazyredraw = true
		vim.api.nvim_feedkeys(keys, "nx", false)
		vim.o.lazyredraw = old
	end
end
-- Unmap them to remove the habit
Keymap("n", "<C-d>", "<Nop>")
Keymap("n", "<C-u>", "<Nop>")
Keymap("n", "<PageDown>", lazy_feedkeys("<C-d>zz"))
Keymap("n", "<PageUp>", lazy_feedkeys("<C-u>zz"))

-- I do not use hjkl anyways
Keymap("n", "l", "<Nop>")

-- Killword backward
Keymap({ "i", "c" }, "<C-BS>", "<C-w>")

-- Rename the word under cursor
Keymap("n", "gr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true, silent = false })

-- Unmap r because I am using it to start own commands
Keymap("n", "r", "<Nop>")

Keymap("", "<CR>", "<Nop>")

---@type "inactive" | "mark_created" | "in_preview"
local curr_preview_state = "inactive"
---@type number
local preview_win = 0
local preview = function()
	if curr_preview_state == "inactive" then
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.api.nvim_buf_set_mark(0, "P", pos[1], pos[2], {})

		curr_preview_state = "mark_created"
		return
	end

	if curr_preview_state == "mark_created" then
		preview_win = vim.api.nvim_open_win(0, false, { split = "right", vertical = true, win = 0 })

		local mark_pos = vim.api.nvim_get_mark("P", {})
		local row = mark_pos[1]
		local col = mark_pos[2]
		local buf = mark_pos[3]

		vim.api.nvim_set_current_buf(buf)
		vim.api.nvim_win_set_cursor(0, { row, col })

		curr_preview_state = "in_preview"
		return
	end

	if curr_preview_state == "in_preview" then
		if preview_win ~= 0 then
			pcall(function()
				vim.api.nvim_win_close(preview_win, false)
			end)
		end

		curr_preview_state = "inactive"
		return
	end
end

-- Navigate between opened windows
Keymap("n", "<BS>", "<C-w>w")
Keymap("n", "<S-Left>", "<C-w>h")
Keymap("n", "<S-Down>", "<C-w>j")
Keymap("n", "<S-Up>", "<C-w>k")
Keymap("n", "<S-Right>", "<C-w>l")

-- No dizziness when searching
Keymap("n", "n", "nzzzv")
Keymap("n", "N", "Nzzzv")

-- Flash/Leap remaps
Keymap("n", "x", "s")
Keymap("n", "X", "r")

-- Unmap these keys to use to jump to lsp errors
Keymap("n", "[", "<Nop>")
Keymap("n", "]", "<Nop>")
unmap("n", "[d")
unmap("n", "]d")
unmap("n", "[D")
unmap("n", "]D")
unmap("n", "[q")
unmap("n", "]q")
unmap("n", "[Q")
unmap("n", "]Q")
unmap("n", "[l")
unmap("n", "]l")
unmap("n", "[L")
unmap("n", "]L")
unmap("n", "[a")
unmap("n", "]a")
unmap("n", "[A")
unmap("n", "]A")
unmap("n", "[b")
unmap("n", "]b")
unmap("n", "[B")
unmap("n", "]B")
unmap("n", "[t")
unmap("n", "]t")
unmap("n", "]T")
unmap("n", "[T")
unmap("n", "[<Space>")
unmap("n", "]<Space>")
unmap("n", "[<C-t>")
unmap("n", "]<C-t>")
unmap("n", "[<C-l>")
unmap("n", "]<C-l>")
unmap("n", "[<C-q>")
unmap("n", "]<C-q>")

unmap("n", "grn")
unmap("n", "grr")
unmap("n", "gri")
unmap("n", "gO")
unmap("n", "gra")

unmap({ "i", "s" }, "<C-s>")
unmap({ "i", "s" }, "<Tab>")

-- Create a split window
Keymap("n", "<Leader>w", ":set splitright<CR>:vsplit<CR>")

-- Disable ex mode
Keymap("n", "Q", "<Nop>")

Keymap("n", "<Leader>t", ":x<CR>")
Keymap("n", "<Leader>T", function()
	local ok = pcall(vim.cmd.tabclose)
	if not ok then
		vim.cmd.qa()
	end
end)

-- Execute macro stored in the q register
Keymap("n", "<C-q>", ":normal @q<CR>")

-- Remap jumplist controls to be more convenient for Colemak-DH
Keymap("n", "<C-o>", "<Nop>")
Keymap("n", "<C-I>", "<Nop>")
-- Unmap go back in buffer tag stack
Keymap("n", "<C-t>", "<Nop>")
Keymap("n", "<C-e>", "<C-I>")
Keymap("n", "<C-n>", "<C-o>")

-- Paste the previously deleted thing
-- useful for swapping stuff
-- goes with TextYankPost autocmd to work around small registers
Keymap("n", "<Leader>p", '"2p')
Keymap("n", "<Leader>P", '"2P')

Keymap("n", "<Leader>c", "ciw")

-- Comment out and paste
Keymap("n", "yc", function()
	vim.cmd(":normal" .. vim.v.count .. "yy")
	vim.cmd(":normal" .. vim.v.count .. "gcc")
	if vim.v.count > 1 then
		vim.cmd(":normal" .. vim.v.count - 1 .. "j")
	end
	vim.cmd(":normal p")
end)

-- Swap regular visual mode with visual line mode
-- since visual line mode is at least marginally useful
Keymap("n", "v", "V")
Keymap("n", "V", "v")

----- VISUAL -----

-- Allows to move selected lines down or up
Keymap("x", "<C-S-Down>", ":m '>+1<CR>gv=gv")
Keymap("x", "<C-S-Up>", ":m '<-2<CR>gv=gv")

-- Disable bindings for the built-in completion
Keymap("x", "<C-N>", "<Nop>")
Keymap("x", "<C-S-N>", "<Nop>")
Keymap("x", "<C-P>", "<Nop>")
Keymap("x", "<C-S-P>", "<Nop>")

----- VISUAL BLOCK MODE -----

-- Delete selected text to void and paste
Keymap("x", "p", '"_dP')

----- INSERT MODE -----

-- Disable bindings for the built-in completion
Keymap("i", "<C-N>", "<Nop>")
Keymap("i", "<C-S-N>", "<Nop>")
Keymap("i", "<C-P>", "<Nop>")
Keymap("i", "<C-S-P>", "<Nop>")

-- Unmap register pasting
Keymap("i", "<C-r>", "<Nop>")
