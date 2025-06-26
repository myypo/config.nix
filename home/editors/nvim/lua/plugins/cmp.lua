return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		{
			"L3MON4D3/LuaSnip",
			config = function()
				local ls = require("luasnip")
				---@diagnostic disable-next-line: unused-local
				local s = ls.snippet
				---@diagnostic disable-next-line: unused-local
				local sn = ls.snippet_node
				---@diagnostic disable-next-line: unused-local
				local t = ls.text_node
				---@diagnostic disable-next-line: unused-local
				local i = ls.insert_node
				---@diagnostic disable-next-line: unused-local
				local f = ls.function_node
				---@diagnostic disable-next-line: unused-local
				local c = ls.choice_node
				---@diagnostic disable-next-line: unused-local
				local d = ls.dynamic_node
				---@diagnostic disable-next-line: unused-local
				local r = ls.restore_node
				require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/lua/luasnip" } })
			end,
		},
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",
	build = "nix run .#build-plugin",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = { preset = "luasnip" },

		keymap = {
			preset = "none",

			["<C-i>"] = { "show_documentation", "hide_documentation", "fallback" },
			["<PageUp>"] = { "scroll_documentation_up", "fallback" },
			["<PageDown>"] = { "scroll_documentation_down", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-t>"] = { "hide", "show" },

			["<C-n>"] = { "snippet_forward", "fallback" },
			["<C-e>"] = { "snippet_backward", "fallback" },

			["<C-c>"] = { "fallback" },
		},

		appearance = {
			highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
			kind_icons = {
				Text = "󰊄",
				Method = "",
				Function = "󰡱",
				Constructor = "",
				Field = "",
				Variable = "󱀍",
				Class = "",
				Interface = "",
				Module = "󰕳",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			},
		},

		cmdline = {
			completion = { menu = { auto_show = true } },
			keymap = {
				preset = "none",

				["<Tab>"] = { "select_and_accept" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-t>"] = { "hide", "show" },
			},
			---@diagnostic disable-next-line: assign-type-mismatch
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == ":" or type == "@" then
					return { "cmdline" }
				end
				return {}
			end,
		},

		completion = {
			list = {
				max_items = 7,
				cycle = {
					from_bottom = true,
					from_top = true,
				},
			},
			menu = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			},
			documentation = {
				window = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
				auto_show = false,
			},
		},

		sources = {
			default = { "lsp", "path", "buffer" },
			per_filetype = {
				-- sql = { "dadbod", "buffer" },
			},
			providers = {
				-- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				lsp = {
					fallbacks = {},
				},
				buffer = {
					max_items = 2,
					min_keyword_length = 3,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
