vim.pack.add({
	GH("nvim-mini/mini.completion"),

	-- Optional dependencies
	GH("nvim-mini/mini.icons"),
	GH("nvim-mini/mini.snippets"),

	-- Snippets
	GH("rafamadriz/friendly-snippets"),
})

require("mini.completion").setup()
require("mini.icons").setup()

local mini_snippets = require("mini.snippets")
mini_snippets.setup({
	snippets = {
		mini_snippets.gen_loader.from_lang(),
	},
})
mini_snippets.start_lsp_server()
