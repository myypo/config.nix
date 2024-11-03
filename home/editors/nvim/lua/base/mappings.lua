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
Keymap("n", "<C-s>", ":w<CR>")

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
Keymap("n", "<C-d>", lazy_feedkeys("<C-d>zz"))
Keymap("n", "<C-u>", lazy_feedkeys("<C-u>zz"))

-- Killword backward
Keymap("i", "<C-BS>", "<C-w>")
Keymap("c", "<C-BS>", "<C-w>")

-- Rename the word under cursor
Keymap("n", "gr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true, silent = false })

-- Unmap r because I am using it to start own commands
Keymap("n", "r", "<Nop>")

-- Unmap go back in buffer tag stack
Keymap("n", "<C-t>", "<Nop>")

Keymap("", "<CR>", "<Nop>")

-- Navigate between opened windows
Keymap("n", "<Tab>", "<C-w>w")
Keymap("n", "<S-Tab>", "<C-w>p")

-- No dizziness when searching
Keymap("n", "n", "nzzzv")
Keymap("n", "N", "Nzzzv")

-- Flash remaps
Keymap("n", "x", "s")
Keymap("n", "X", "r")

-- Unmap these keys to use to jump to lsp errors
Keymap("n", "[", "<Nop>")
Keymap("n", "]", "<Nop>")
unmap("n", "[d")
unmap("n", "]d")

-- Create a split screen
Keymap("n", "<C-w>", ":set splitright<CR>:vsplit<CR>")

-- Disable ex mode
Keymap("n", "Q", "<Nop>")

Keymap("n", "<C-a>", ":x<CR>")
Keymap("n", "<C-S-a>", function()
	local ok = pcall(vim.cmd.tabclose)
	if not ok then
		vim.cmd.qa()
	end
end)

-- Execute macro stored in the q register
Keymap("n", "<C-q>", ":normal @q<CR>")

-- Map jump to the next position to Ctrl+i
Keymap("n", "<C-i>", "<C-I>")

-- Use ' for accessing registers
-- since marks are too much anyways
Keymap("n", "'", "<Nop>")
Keymap("n", "'", '"')

-- Paste the previously deleted thing
-- useful for swapping stuff
-- goes with TextYankPost autocmd to work around small registers
Keymap("n", "<C-p>", '"2p')
Keymap("n", "<C-S-p>", '"2P')

----- VISUAL -----

-- Allows to move selected lines down or up
Keymap("v", "<S-Down>", ":m '>+1<CR>gv=gv")
Keymap("v", "<S-Up>", ":m '<-2<CR>gv=gv")

-- Disable bindings for the built-in completion
Keymap("v", "<C-N>", "<Nop>")
Keymap("v", "<C-S-N>", "<Nop>")
Keymap("v", "<C-P>", "<Nop>")
Keymap("v", "<C-S-P>", "<Nop>")

----- VISUAL BLOCK MODE -----

-- Delete selected text to void and paste
Keymap("x", "<Leader>p", '"_dP')

----- INSERT MODE -----

-- Disable bindings for the built-in completion
Keymap("i", "<C-N>", "<Nop>")
Keymap("i", "<C-S-N>", "<Nop>")
Keymap("i", "<C-P>", "<Nop>")
Keymap("i", "<C-S-P>", "<Nop>")
