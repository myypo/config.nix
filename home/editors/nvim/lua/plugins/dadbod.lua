return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod" },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{
			"<Leader>l",
			function()
				vim.cmd(":tabnew")
				vim.cmd(":DBUI")
			end,
		},
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.vim_dadbod_completion_mark = ""

		vim.g.db_ui_env_variable_url = "DATABASE_URL"
		vim.g.db_ui_env_variable_name = "DATABASE_NAME"

		vim.g.vim_dadbod_completion_lowercase_keywords = 1
		vim.g.vim_dadbod_completion_disable_notifications = 1
	end,
}
