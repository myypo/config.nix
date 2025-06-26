return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },

			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("dapui").setup({
					-- Makes the UI as minimal as possible
					layouts = {
						{
							elements = {
								{
									id = "scopes",
									size = 0.50,
								},
							},
							position = "left",
							size = 96,
						},
					},
				})

				local sign = vim.fn.sign_define
				sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
				sign(
					"DapBreakpointCondition",
					{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
				)
				sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			end,
		},
		{
			"leoluz/nvim-dap-go",
			config = function()
				require("dap-go").setup({
					dap_configurations = {
						{
							type = "go",
							name = "Attach remote",
							mode = "remote",
							request = "attach",
							port = function()
								return vim.fn.input("Select port: ", 34298)
							end,
							cwd = "${workspaceFolder}",
						},
					},
				})
			end,
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			dependencies = {
				{
					"microsoft/vscode-js-debug",
					version = "1.x",
					build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
				},
			},
			config = function()
				require("dap-vscode-js").setup({
					debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				})
			end,
		},
	},

	keys = {
		-- { "<C-b>", "<Cmd>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
		-- { "<C-x>", "<Cmd>DapTerminate<CR>", desc = "Stop debugging" },
		-- { "<C-g>", "<Cmd>DapContinue<CR>", desc = "Start debugging" },
		--
		-- { "<leader>d", "<Cmd>lua require('dapui').toggle()<CR>", desc = "dapui_toggle" },
	},

	config = function()
		local dap = require("dap")
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		dap.configurations.c = dap.configurations.cpp

		local js_based_dev_tools = { "typescript", "javascript", "typescriptreact" }
		for _, language in ipairs(js_based_dev_tools) do
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					port = function()
						return vim.fn.input("Select port: ", 9229)
					end,
					name = "Attach",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = 'Start Chrome with "localhost"',
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
				},
			}
		end
	end,
}
