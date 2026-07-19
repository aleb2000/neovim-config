vim.pack.add{
  gh("mason-org/mason.nvim"),
  gh("mason-org/mason-lspconfig.nvim")
}

require("mason").setup()
require("mason-lspconfig").setup()
