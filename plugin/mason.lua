vim.pack.add({
	GH("mason-org/mason.nvim"),
	GH("mason-org/mason-lspconfig.nvim"),
})

require("mason").setup()
require("mason-lspconfig").setup()
