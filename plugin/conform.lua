vim.pack.add({
	GH("stevearc/conform.nvim"),
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		go = { "gofmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})
