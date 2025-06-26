return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"Davidyz/VectorCode",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		-- "ravitemer/mcphub.nvim",
	},
	keys = {
		{ "<Leader>d", "<Cmd>CodeCompanionChat<CR>" },
	},
	cmd = { "CodeCompanion" },

	config = function()
		require("codecompanion").setup({
			extensions = {
				vectorcode = {
					opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
				},
			},
			strategies = {
				chat = {
					adapter = "gemini",
					model = "gemini-2.5-pro-preview",
					-- tools = {
					-- 	["mcp"] = {
					-- 		callback = function()
					-- 			return require("mcphub.extensions.codecompanion")
					-- 		end,
					-- 		description = "Call tools and resources from the MCP Servers",
					-- 		opts = {
					-- 			requires_approval = true,
					-- 		},
					-- 	},
					-- },
				},
				inline = {
					adapter = "gemini",
					model = "gemini-2.5-flash-preview",
				},
				cmd = {
					adapter = "gemini-2.5-pro-preview",
				},
			},
			adapters = {
				deepseek_chat = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = vim.env.OPENROUTER_API_KEY,
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "deepseek/deepseek-chat-v3-0324:free",
							},
						},
					})
				end,
				deepseek_r1 = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = vim.env.OPENROUTER_API_KEY,
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "deepseek/deepseek-r1:free",
							},
						},
					})
				end,
			},
		})
	end,
}
