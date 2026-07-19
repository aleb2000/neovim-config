vim.pack.add({
	gh("mfussenegger/nvim-dap"),
	gh("theHamsta/nvim-dap-virtual-text"),
})

require("nvim-dap-virtual-text").setup()
