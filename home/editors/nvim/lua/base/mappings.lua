---@param mode string | string[]
---@param key string
---@param fun string | function
---@param opts? table<string, boolean>
local keymap = function(mode, key, fun, opts)
	vim.keymap.set(mode, key, fun, opts or { noremap = true, silent = true })
end

---@param mode string | string[]
---@param key string
local unmap = function(mode, key)
	vim.keymap.del(mode, key)
end

-- Remap space as Leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "

----- NORMAL -----

-- Prevents cursor from moving when using J
keymap("n", "J", "mzJ`z")
keymap("n", "<C-s>", ":w<CR>")

-- No dizziness when navigating
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Killword backward
keymap("i", "<C-BS>", "<C-w>")
keymap("c", "<C-BS>", "<C-w>")

-- Rename the word under cursor
keymap("n", "gr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true, silent = false })

-- Unmap r because I am using it to start own commands
keymap("n", "r", "<Nop>")

-- Unmap go back in buffer tag stack
keymap("n", "<C-t>", "<Nop>")

-- Unmap everything related to tab management, I do not use tabs
keymap("n", "gt", "<Nop>")
keymap("n", "gT", "<Nop>")

-- Navigate between opened windows
keymap("n", "<Tab>", "<C-w>w")
keymap("n", "<S-Tab>", "<C-w>p")

-- No dizziness when searching
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Flash remaps
keymap("n", "x", "s")
keymap("n", "X", "r")

-- Unmap these keys to use to jump to lsp errors
keymap("n", "[", "<Nop>")
keymap("n", "]", "<Nop>")
unmap("n", "[d")
unmap("n", "]d")

-- Create a split screen
keymap("n", "<C-w>", ":set splitright<CR>:vsplit<CR>")

-- Disable ex mode
keymap("n", "Q", "<Nop>")

keymap("n", "<C-a>", ":x<CR>")
keymap("n", "<C-S-a>", function()
	local ok = pcall(vim.cmd.tabclose)
	if not ok then
		vim.cmd.qa()
	end
end)

-- Execute macro stored in the q register
keymap("n", "<C-q>", ":normal @q<CR>")

-- Map jump to the next position to Ctrl+i
keymap("n", "<C-i>", "<C-I>")

-- Use ' for accessing registers
-- since marks are too much anyways
keymap("n", "'", "<Nop>")
keymap("n", "'", '"')

-- Paste the previously deleted thing
-- useful for swapping stuff
-- goes with TextYankPost autocmd to work around small registers
keymap("n", "<C-p>", '"2p')
keymap("n", "<C-S-p>", '"2P')

----- VISUAL -----

-- Allows to move selected lines down or up
keymap("v", "<S-Down>", ":m '>+1<CR>gv=gv")
keymap("v", "<S-Up>", ":m '<-2<CR>gv=gv")

-- Disable bindings for the built-in completion
keymap("v", "<C-N>", "<Nop>")
keymap("v", "<C-S-N>", "<Nop>")
keymap("v", "<C-P>", "<Nop>")
keymap("v", "<C-S-P>", "<Nop>")

----- VISUAL BLOCK MODE -----

-- Delete selected text to void and paste
keymap("x", "<Leader>p", '"_dP')

----- INSERT MODE -----

-- Disable bindings for the built-in completion
keymap("i", "<C-N>", "<Nop>")
keymap("i", "<C-S-N>", "<Nop>")
keymap("i", "<C-P>", "<Nop>")
keymap("i", "<C-S-P>", "<Nop>")
