return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
	},
	ft = { "go", "gomod" },
	config = function()
		require("go").setup({
			null_ls_document_formatting_disable = true,
			tag_options = "json=",

			lsp_cfg = true,
			diagnostic = false,
			lsp_inlay_hints = { enable = false },
			lsp_keymaps = false,
			lsp_codelens = false,
		})

		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
			group = format_sync_grp,
		})
	end,
}
