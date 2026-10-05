vim.pack.add({
	{ src = GH("nvim-telescope/telescope.nvim"), version = vim.version.range("0.2") },

	-- Dependencies
	GH("nvim-lua/plenary.nvim"),
	GH("nvim-telescope/telescope-fzf-native.nvim"),
})

-- Make telescope-fzf-native on update
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "telescope-fzf-native.nvim" then
			local infos = vim.pack.get({ "telescope-fzf-native.nvim" })
			for _, info in ipairs(infos) do
				vim.system({ "make" }, { cwd = info.path })
			end
		end
	end,
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", function()
	builtin.live_grep({
		prompt_title = "Live Grep",
		additional_args = function()
			return { "--engine=auto" }
		end,
	})
end, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Telescope Treesitter names" })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope LSP references" })
