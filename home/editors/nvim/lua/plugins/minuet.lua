return {
	-- "louis-brunet/zeta.nvim",
	-- ---@type zeta.Opts
	-- opts = {
	-- 	backend = "zed",
	-- 	backend_config = {
	-- 		openai = { url = "https://openrouter.ai/api/v1/completions" },
	-- 		-- zed = {},
	-- 	},
	-- },
	-- config = function(_, opts)
	-- 	local zeta = require("zeta")
	-- 	local zeta_autocmd = require("zeta.autocmd")
	-- 	local zeta_api = require("zeta.api")
	--
	-- 	zeta.setup(opts)
	-- 	zeta_autocmd.setup()
	--
	-- 	vim.keymap.set("n", "<Tab>", zeta_api.accept)
	-- end,

	-- "copilotlsp-nvim/copilot-lsp",
	-- init = function()
	-- 	vim.g.copilot_nes_debounce = 50
	-- 	vim.lsp.enable("copilot_ls")
	-- 	vim.keymap.set({ "n", "i" }, "<Tab>", function()
	-- 		require("copilot-lsp.nes").apply_pending_nes(0)
	-- 	end)
	-- end,

	-- "supermaven-inc/supermaven-nvim",
	-- config = function()
	-- 	require("supermaven-nvim").setup({
	-- 		keymaps = {
	-- 			accept_suggestion = "<Tab>",
	-- 			clear_suggestion = "<C-]>",
	-- 			accept_word = "<C-j>",
	-- 		},
	-- 		ignore_filetypes = {},
	-- 		disable_keymaps = false, -- disables built in keymaps for more manual control
	-- 	})
	-- end,

	"milanglacier/minuet-ai.nvim",
	dependencies = {
		{
			"Davidyz/VectorCode",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	event = "InsertEnter",
	keys = {
		{
			"<Tab>",
			function()
				local action = require("minuet.virtualtext").action
				if action.is_visible() then
					action.accept()
					return
				end

				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)

				-- local _, col = unpack(vim.api.nvim_win_get_cursor(0))
				-- local line = vim.api.nvim_get_current_line()
				-- local before_cursor = line:sub(1, col)
				-- local only_whitespace_behind = before_cursor:match("^%s*$") ~= nil
				-- if only_whitespace_behind then
				-- 	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
				-- 	return
				-- end
				--
				-- action.next()
			end,
			mode = "i",
		},
		{
			"<C-c>",
			function()
				require("minuet.virtualtext").action.next()
			end,
			mode = "i",
			desc = "Next completion",
		},
		{
			"<C-d>",
			function()
				require("minuet.virtualtext").action.dismiss()
			end,
			mode = "i",
		},
	},

	config = function()
		require("vectorcode").setup({
			-- number of retrieved documents
			n_query = 1,
		})
		local vectorcode_config = require("vectorcode.config")
		local vectorcode_cacher = vectorcode_config.get_cacher_backend()

		-- roughly equate to 2000 tokens for LLM
		local RAG_Context_Window_Size = 8000

		local gemini = {
			model = "gemini-2.5-flash-preview-05-20",
			optional = {
				generationConfig = {
					maxOutputTokens = 500,
					-- When using `gemini-2.5-flash`, it is recommended to entirely
					-- disable thinking for faster completion retrieval.
					thinkingConfig = {
						thinkingBudget = 0,
					},
				},
				safetySettings = {
					{ category = "HARM_CATEGORY_DANGEROUS_CONTENT", threshold = "BLOCK_NONE" },
					{ category = "HARM_CATEGORY_HARASSMENT", threshold = "BLOCK_NONE" },
					{ category = "HARM_CATEGORY_SEXUALLY_EXPLICIT", threshold = "BLOCK_NONE" },
				},
			},
			system = {
				template = "{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}\n{{{repo_context}}}",
				repo_context = [[9. Additional context from other files in the repository will be enclosed in <repo_context> tags. Each file will be separated by <file_separator> tags, containing its relative path and content.]],
			},
			chat_input = {
				template = "{{{repo_context}}}\n{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}",
				repo_context = function(_, _, _)
					local prompt_message = ""
					local cache_result = vectorcode_cacher.query_from_cache(0)
					for _, file in ipairs(cache_result) do
						prompt_message = prompt_message .. "<file_separator>" .. file.path .. "\n" .. file.document
					end

					prompt_message = vim.fn.strcharpart(prompt_message, 0, RAG_Context_Window_Size)

					if prompt_message ~= "" then
						prompt_message = "<repo_context>\n" .. prompt_message .. "\n</repo_context>"
					end
					return prompt_message
				end,
			},
		}

		require("minuet").setup({
			provider = "gemini",
			request_timeout = 2.5,
			throttle = 1000, -- Increase to reduce costs and avoid rate limits
			debounce = 400, -- Increase to reduce costs and avoid rate limits
			provider_options = {
				openai_fim_compatible = {
					api_key = "OPENROUTER_API_KEY",
					end_point = "https://openrouter.ai/api/v1/completions",
					model = "deepseek/deepseek-chat-v3-0324:free",
					name = "OpenRouter",
					optional = {
						max_tokens = 128,
						provider = {
							sort = "throughput",
						},
					},
				},

				gemini = gemini,
			},
			completion = { trigger = { prefetch_on_insert = false } },
			n_completions = 1,
			virtualtext = {
				auto_trigger_ft = {},
			},
		})
	end,
}
