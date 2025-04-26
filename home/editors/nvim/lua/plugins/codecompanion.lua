return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "ravitemer/mcphub.nvim",
	},
	keys = {
		{ "<Leader>d", "<Cmd>CodeCompanionChat<CR>" },
	},
	cmd = { "CodeCompanion" },

	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "gemini_chat",
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
					adapter = "gemini_chat",
				},
				cmd = {
					adapter = "gemini_chat",
				},
			},
			adapters = {
				gemini_chat = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = vim.env.OPENROUTER_API_KEY,
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "google/gemini-2.5-pro-exp-03-25",
							},
						},
					})
				end,
				deepseek_chat = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = vim.env.OPENROUTER_API_KEY,
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "deepseek/deepseek-chat:free",
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
