require("ibl").setup({
	exclude = {
		buftypes = { "terminal" },
		filetypes = { "dashboard" },
	},
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
	},
})
