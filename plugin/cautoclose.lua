-- Bind to auto close the quickfix list on selection
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(args)
		-- Map Shift + Enter to jump and close
		vim.keymap.set("n", "<S-CR>", "<CR>:cclose<CR>", {
			buffer = args.buf,
			silent = true,
			noremap = true,
		})
	end,
	desc = "Jump to selected location in the QuickFix list and close the list",
})
