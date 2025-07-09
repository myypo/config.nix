local options = {
	clipboard = "unnamedplus",
	mouse = "",
	whichwrap = vim.o.whichwrap .. "<,>,[,],h,l",
	showmode = false,
	shortmess = vim.o.shortmess .. "I",

	laststatus = 0,

	undofile = true,
	ignorecase = true,
	smartcase = true,

	smartindent = true,
	autoindent = true,
	hidden = true,
	expandtab = true,
	cmdheight = 1,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,

	number = true,
	numberwidth = 2,
	relativenumber = true,
	cursorline = true,
	cursorlineopt = "number",
	signcolumn = "yes",
	ruler = false,
	scrolloff = 8,

	fileencodings = "utf-8,gbk",

	-- I can afford setting such a big updatetime thanks to antoinemadec/FixCursorHold.nvim
	updatetime = 4000,

	timeoutlen = 300,

	foldenable = false,
	foldlevel = 99,

	hlsearch = false,
	incsearch = true,

	-- Disable default completion menu
	completeopt = "",
	wildmenu = false,

	autoread = true,

	-- Do not show tabs
	showtabline = 0,

	-- Treat hyphen as a part of word
	iskeyword = "@,48-57,_,192-255,-",

	winborder = "rounded",
}

for k, v in pairs(options) do
	vim.o[k] = v
end

local globals = {
	no_plugin_maps = 1,

	did_install_default_menus = 1,
	did_install_syntax_menu = 1,

	-- Do not load native syntax completion
	loaded_syntax_completion = 1,

	-- Do not load spell files
	loaded_spellfile_plugin = 1,

	loaded_netrw = 1,
	loaded_netrwFileHandlers = 1,
	loaded_netrwPlugin = 1,
	loaded_netrwSettings = 1,
	netrw_liststyle = 3,

	-- Do not load tohtml.vim
	loaded_2html_plugin = 1,

	-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all of these plugins are
	-- related to reading files inside compressed containers)
	loaded_gzip = 1,
	loaded_tar = 1,
	loaded_tarPlugin = 1,
	loaded_vimball = 1,
	loaded_vimballPlugin = 1,
	loaded_zip = 1,
	loaded_zipPlugin = 1,

	-- Do not use builtin matchit.vim and matchparen.vim
	loaded_matchit = 1,
	loaded_matchparen = 1,

	-- Disable sql omni completion
	loaded_sql_completion = 1,
	omni_sql_no_default_maps = 1,

	-- Set this to 0 in order to disable native EditorConfig support
	editorconfig = 1,

	-- FIXME: https://github.com/neovim/neovim/issues/32660
	-- _ts_force_sync_parsing = true,
}

for k, v in pairs(globals) do
	vim.g[k] = v
end
