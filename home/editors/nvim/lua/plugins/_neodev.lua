return {
	"folke/neodev.nvim",
	ft = "lua",
	opts = {},
	config = function()
		require("neodev").setup({
			library = {
				enabled = true,
				plugins = false,
			},
			override = function(root_dir, library)
				if root_dir:find("@flake-path@", 1, true) == 1 then
					library.plugins = true
				end
			end,
		})

		local nvim_lsp = require("lspconfig")
		nvim_lsp.lua_ls.setup({
			settings = {
				Lua = {
					semantic = {
						enable = false,
					},
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = true,
					},
					format = {
						enable = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
