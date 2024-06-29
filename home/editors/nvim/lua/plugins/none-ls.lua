return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local b = require("null-ls").builtins
		require("null-ls").setup({
			sources = {
				-- Lua
				b.formatting.stylua,

				-- Python
				b.formatting.black,

				-- TS/JS
				b.formatting.prettier,

				-- Go
				b.formatting.gofumpt,
				b.formatting.golines,

				-- Nix
				b.formatting.alejandra,

				-- Bash
				b.formatting.shfmt,

				-- Fish
				b.diagnostics.fish,
				b.formatting.fish_indent,

				-- SQL
				b.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
			},

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
