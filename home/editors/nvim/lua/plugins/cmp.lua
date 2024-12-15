return {
	"iguanacucumber/magazine.nvim",
	name = "nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp" },
		{ "iguanacucumber/mag-buffer", name = "cmp-buffer" },
		{ "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },

		"https://codeberg.org/FelipeLema/cmp-async-path",

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
			---@diagnostic disable-next-line: missing-fields
			performance = {
				max_view_entries = 7,
			},
			mapping = cmp.mapping({
				["<C-n>"] = cmp.mapping(function(fallback)
					-- Trigger a custom snippet if possible
					-- despite it not being visible in the cmp menu
					if ls.expand_or_jumpable() then
						ls.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s", "v" }),
				["<C-e>"] = cmp.mapping(function(fallback)
					if ls.jumpable(-1) then
						ls.jump(-1)
					else
						fallback()
					end
				end, { "i", "s", "v" }),
				["<C-i>"] = function()
					if cmp.visible_docs() then
						cmp.close_docs()
					else
						cmp.open_docs()
					end
				end,
				["<PageUp>"] = cmp.mapping.scroll_docs(-4), -- Up
				["<PageDown>"] = cmp.mapping.scroll_docs(4), -- Down
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end),
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
				["<C-t>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
						fallback()
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
					cmp.config.compare.offset,
					cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
					cmp.config.compare.locality,
					cmp.config.compare.recently_used,
					cmp.config.compare.order,
				},
			},
			sources = cmp.config.sources({
				{ name = "async_path", priority = 8 },
				{ name = "nvim_lsp", priority = 8 },
				{ name = "lazydev", group_index = 0 }, -- Completions specific to Lua
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
				["<C-t>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
							fallback()
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
			---@diagnostic disable-next-line: missing-fields
			matching = { disallow_symbol_nonprefix_matching = false },
			sources = cmp.config.sources({
				{ name = "async_path" },
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
