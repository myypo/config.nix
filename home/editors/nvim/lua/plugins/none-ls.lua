return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local nls = require("null-ls")
		local b = nls.builtins

		require("null-ls").setup({
			sources = {
				-- Lua
				b.formatting.stylua,

				-- Python
				b.formatting.black,

				-- TS/JS
				b.formatting.prettierd,

				-- Go
				b.formatting.golines.with({
					extra_args = { "--base-formatter", "gofumpt" },
				}),

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

				-- Roc
				{
					method = nls.methods.FORMATTING,
					filetypes = { "roc" },
					generator = nls.generator({
						command = "roc fmt",
						args = function(_)
							return {}
						end,
						to_stdin = true,
						on_output = function(_, _)
							return {}
						end,
					}),
				},
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
