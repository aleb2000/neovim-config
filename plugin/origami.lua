vim.pack.add({
	gh("chrisgrieser/nvim-origami"),
})

require("origami").setup({
	autoFold = {
		enabled = false,
	},
	foldKeymaps = {
		setup = false,
	},
})
