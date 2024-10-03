return {
	-- TODO: revert to the upstream after this is merged: https://github.com/hrsh7th/nvim-cmp/pull/1980
	"yioneko/nvim-cmp", -- "hrsh7th/nvim-cmp",
	branch = "perf-up",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},

	config = function()
		local cmp = require("cmp")

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

		local kind_icons = {
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
		}

		cmp.setup({
			view = {
				docs = {
					auto_open = false,
				},
			},

			preselect = cmp.PreselectMode.Item,
			snippet = {
				expand = function(args)
					ls.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone",
			},
			performance = {
				max_view_entries = 7,
			},
			mapping = cmp.mapping({
				["<C-N>"] = cmp.mapping(function(fallback)
					if ls.expand_or_jumpable() then
						ls.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s", "v" }),
				["<C-S-N>"] = cmp.mapping(function(fallback)
					if ls.jumpable(-1) then
						ls.jump(-1)
					else
						fallback()
					end
				end, { "i", "s", "v" }),
				["<C-E>"] = function()
					if cmp.visible_docs() then
						cmp.close_docs()
					else
						cmp.open_docs()
					end
				end,
				["<C-U>"] = cmp.mapping.scroll_docs(-4), -- Up
				["<C-D>"] = cmp.mapping.scroll_docs(4), -- Down
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Down>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<Up>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-a>"] = cmp.mapping(function(_)
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end, { "i", "s" }),
			}),
			formatting = {
				expandable_indicator = true,
				fields = { "kind", "abbr", "menu" },
				format = function(_, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					return vim_item
				end,
			},
			sorting = {
				priority_weight = 1.0,
				comparators = {
					cmp.config.compare.locality,
					cmp.config.compare.recently_used,
					cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
					cmp.config.compare.offset,
					cmp.config.compare.order,
				},
			},
			sources = cmp.config.sources({
				{ name = "luasnip", priority = 9, max_item_count = 2 },
				{ name = "path", priority = 8 },
				{
					name = "nvim_lsp",
					priority = 8,
				},
				{ name = "buffer", priority = 4, max_item_count = 2, keyword_length = 3 },
			}),

			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				}),
			},
			experimental = {
				ghost_text = false,
				native_menu = false,
			},
		})

		cmp.setup.cmdline(":", {
			experimental = {
				ghost_text = false,
				native_menu = false,
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			mapping = cmp.mapping({
				["<C-a>"] = {
					c = function(_)
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end,
				},
				["<Down>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
				},
				["<Up>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
				},
				["<Right>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end,
				},
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline_history" },
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
	end,
}
