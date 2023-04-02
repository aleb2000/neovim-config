local chadtree_settings = {
	theme = {
		text_colour_set = "nord"
	},
	keymap = {
		tertiary = { "<C-enter>", "<middlemouse>" }
	}
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

vim.api.nvim_set_keymap("n", "<leader>v", ":CHADopen<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":call setqflist([])<CR>", { noremap = true })
