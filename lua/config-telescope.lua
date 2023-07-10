local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fp", builtin.planets, {})

require("telescope").setup({
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				--		["i"] = {
				--			-- your custom insert mode mappings
				--		},
				--		["n"] = {
				--			-- your custom normal mode mappings
				--		},
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

vim.api.nvim_set_keymap(
	"n",
	"<leader>fi",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true }
)
