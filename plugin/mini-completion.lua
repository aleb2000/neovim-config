vim.pack.add{
  gh("nvim-mini/mini.completion"),

  -- Optional dependencies
  gh("nvim-mini/mini.icons"),
  gh("nvim-mini/mini.snippets"),

  -- Snippets
  gh("rafamadriz/friendly-snippets"),
}

require("mini.completion").setup()
require("mini.icons").setup()

local mini_snippets = require("mini.snippets")
mini_snippets.setup({
	snippets = {
		mini_snippets.gen_loader.from_lang(),
	}
})
mini_snippets.start_lsp_server()
