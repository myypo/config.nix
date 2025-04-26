return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
	},
	ft = { "go", "gomod" },
	config = function()
		local get_current_gomod = function()
			local file = io.open("go.mod", "r")
			if file == nil then
				return nil
			end

			local first_line = file:read()
			local mod_name = first_line:gsub("module ", "")
			file:close()
			return mod_name
		end

		require("go").setup({
			null_ls_document_formatting_disable = false,
			tag_options = "json=",

			lsp_cfg = {
				-- HACK: because experiencing issues with diagnostics never disappearing
				flags = {
					allow_incremental_sync = false,
				},

				settings = {
					gopls = {
						-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
						-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
						-- not supported
						analyses = nil,
						codelenses = {
							generate = true, -- show the `go generate` lens.
							gc_details = false, -- Show a code lens toggling the display of gc's choices.
							test = true,
							tidy = true,
							vendor = true,
							regenerate_cgo = false,
							upgrade_dependency = false,
						},
						hints = vim.empty_dict(),
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						matcher = "Fuzzy",
						diagnosticsDelay = "1s",
						diagnosticsTrigger = "Edit",
						symbolMatcher = "FastFuzzy",
						semanticTokenTypes = { string = false },
						semanticTokens = true,
						vulncheck = "Imports",
						["local"] = get_current_gomod(),
						buildFlags = { "-tags", "integration" },
					},
				},
			},
			diagnostic = false,
			lsp_inlay_hints = { enable = false },
			lsp_keymaps = false,
			lsp_codelens = false,
		})
	end,
}
