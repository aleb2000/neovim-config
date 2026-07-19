vim.pack.add({
	gh("stevearc/conform.nvim"),
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})
