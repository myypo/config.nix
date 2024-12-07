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

				-- Purescript
				b.formatting.purs_tidy,

				-- Rust
				{
					method = nls.methods.FORMATTING,
					filetypes = { "rust" },
					generator = formatter_generator("rustfmt", { "-q", "$FILENAME" }),
				},

				-- Roc
				{
					method = nls.methods.FORMATTING,
					filetypes = { "roc" },
					generator = formatter_generator("roc fmt", { "$FILENAME" }),
				},

				-- Rescript
				{
					method = nls.methods.FORMATTING,
					filetypes = { "rescript" },
					generator = formatter_generator("rescript format", { "$FILENAME" }),
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
