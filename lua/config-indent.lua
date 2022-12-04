require('indent_blankline').setup {
	buftype_exclude = {"terminal" },
	filetype_exclude = { "dashboard" },
	show_current_context = true,
	space_char_blankline = " ",
	use_treesitter = true,
	show_trailing_blankline_indent = false,
}
