vim.pack.add({
	GH("chrisgrieser/nvim-origami"),
})

require("origami").setup({
	autoFold = {
		enabled = false,
	},
	foldKeymaps = {
		setup = false,
	},
})
