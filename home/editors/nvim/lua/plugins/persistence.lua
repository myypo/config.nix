return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		options = { "buffers" },
	},
	config = {
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				require("persistence").load()
			end,
			nested = true,
		}),

		-- -- Avoid saving buffers that are not directly open
		-- vim.api.nvim_create_autocmd("User", {
		-- 	pattern = "PersistenceSavePre",
		-- 	callback = function()
		-- 		local tabs = vim.api.nvim_list_tabpages()
		--
		-- 		local visible_bufs = {}
		-- 		for _, t in pairs(tabs) do
		-- 			local wins = vim.api.nvim_tabpage_list_wins(t)
		--
		-- 			for _, w in pairs(wins) do
		-- 				local b = vim.api.nvim_win_get_buf(w)
		--
		-- 				if vim.bo[b].buftype == "" then
		-- 					table.insert(visible_bufs, b)
		-- 				end
		-- 			end
		-- 		end
		--
		-- 		for _, b in pairs(vim.api.nvim_list_bufs()) do
		-- 			if not vim.list_contains(visible_bufs, b) then
		-- 				vim.api.nvim_buf_delete(b, {})
		-- 			end
		-- 		end
		-- 	end,
		-- }),
	},
}
