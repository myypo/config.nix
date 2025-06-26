return {
	"yioneko/nvim-vtsls",
	dependencies = { "neovim/nvim-lspconfig" },
	ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },

	config = function()
		local nvim_lsp = require("lspconfig")

		nvim_lsp.denols.setup({
			root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
			single_file_support = false,
			on_attach = function(client, _)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		})

		nvim_lsp.vtsls.setup({
			root_dir = nvim_lsp.util.root_pattern("package.json"),
			single_file_support = false,
			on_attach = function(client, _)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		})
	end,
}
