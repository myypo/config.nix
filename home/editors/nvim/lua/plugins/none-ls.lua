return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local nls = require("null-ls")
		local b = nls.builtins
		local h = require("null-ls.helpers")

		---@param cmd string
		---@param args table
		local function formatter_generator(cmd, args)
			return h.formatter_factory({
				command = cmd,
				args = args,
				cwd = nil,
				to_stdin = true,
				multiple_files = false,
			})
		end

		nls.setup({
			sources = {
				-- Lua
				b.formatting.stylua,

				-- Python
				b.formatting.black,

				-- TS/JS
				b.formatting.prettierd,

				-- -- Go
				b.formatting.golines.with({
					extra_args = { "--base-formatter", "gofumpt" },
				}),

				-- SQL
				b.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),

				-- Nix
				b.formatting.nixfmt,

				-- Bash
				b.formatting.shfmt,

				-- Fish
				b.diagnostics.fish,
				b.formatting.fish_indent,

				-- Purescript
				b.formatting.purs_tidy,

				-- Roc
				{
					method = nls.methods.FORMATTING,
					filetypes = { "roc" },
					generator = formatter_generator("roc fmt", { "$FILENAME" }),
				},
			},

			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
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
