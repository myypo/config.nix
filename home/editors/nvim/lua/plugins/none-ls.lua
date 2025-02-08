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

		local run_formatter = function(text)
			local split = vim.split(text, "\n")
			local result = table.concat(vim.list_slice(split, 2, #split - 1), "\n")

			local j = require("plenary.job"):new({
				command = "sqlfluff",
				args = { "fix", "--dialect", "postgres", "--disable-progress-bar", "-n", "-" },
				writer = { result },
			})
			return j:sync()
		end
		local literals = {
			rust = { "string_literal", "raw_string_literal" },
			python = { "string_content" },
		}

		local function generate_query(lang, nodes)
			local node_string = table.concat(nodes, ")\n\t\t(")
			local query = string.format(
				[[
	([
		(%s)
	] @sql
		(#match? @sql "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
		(#offset! @sql 1 0 -1 0))
]],
				node_string
			)
			return lang, query
		end

		local queries = {}
		for lang, nodes in pairs(literals) do
			local language, query_string = generate_query(lang, nodes)
			queries[lang] = {
				language = language,
				query = query_string,
			}
		end

		local get_root = function(bufnr, lang)
			local parser = vim.treesitter.get_parser(bufnr, lang, {})
			local tree = parser:parse()[1]
			return tree:root()
		end

		local format_sql = function(bufnr)
			bufnr = bufnr or vim.api.nvim_get_current_buf()

			local changes = {}
			for _, query in pairs(queries) do
				local root = get_root(bufnr, query.language)
				local embedded_sql = vim.treesitter.query.parse(query.language, query.query)
				for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
					local name = embedded_sql.captures[id]
					if name == "sql" then
						local range = { node:range() }
						local indentation = string.rep(" ", range[2])

						local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

						for idx, line in ipairs(formatted) do
							formatted[idx] = indentation .. line
						end

						-- Keep track of changes
						--    But insert them in reverse order of the file,
						--    so that when we make modifications, we don't have
						--    any out of date line numbers
						table.insert(changes, 1, {
							start = range[1] + 1,
							final = range[3],
							formatted = formatted,
						})
					end
				end
			end

			for _, change in ipairs(changes) do
				vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
			end
		end

		nls.register({
			name = "format-embedded-sql",
			method = { nls.methods.CODE_ACTION },
			filetypes = { "rust" },
			generator = {
				fn = function()
					return {
						{
							title = "Format embedded SQL",
							action = function()
								format_sql()
							end,
						},
					}
				end,
			},
		})

		nls.setup({
			sources = {
				-- Lua
				b.formatting.stylua,

				-- Python
				b.formatting.black,

				-- TS/JS
				b.formatting.prettierd,

				-- -- Go
				-- b.formatting.golines.with({
				-- 	extra_args = { "--base-formatter", "gofumpt" },
				-- }),

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
