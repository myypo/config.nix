require("base")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local opts = {
	ui = {
		size = { width = 1.0, height = 1.0 },
	},
	dev = {
		-- directory where you store your local plugin projects
		path = "~/code/my/forks",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = { "@github-username@" }, -- For example {"folke"}
		fallback = true, -- Fallback to git when local plugin doesn't exist
	},
}
require("lazy").setup("plugins", opts)
