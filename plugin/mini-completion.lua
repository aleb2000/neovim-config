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

-- Automate filepath completion
-- Adapted from: https://github.com/nvim-mini/mini.nvim/discussions/1995

local function simulate_keypress(key)
	local termcodes = vim.api.nvim_replace_termcodes(key, true, true, true)
	vim.api.nvim_feedkeys(termcodes, "n", false)
end

-- Filepath completion when typing the / character
vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function()
		-- It's better to use a more robust logic to check
		-- whether the leading path-like string is a real path,
		-- for example, check if it exits on the disk.
		if vim.v.char ~= "/" then
			return
		end

		-- Avoid duplicate `/`
		local line, cur = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)
		local prev_char = line:sub(cur[2], cur[2])
		if prev_char == "/" then
			vim.v.char = ""
		end

		-- Force path completion
		simulate_keypress("<C-x><C-f>")
	end,
})

-- Filepath completion when a directory has been filled in by the completion
vim.api.nvim_create_autocmd("CompleteDone", {
	callback = function()
		if vim.v.completed_item.word == nil then
			return
		end

		if
			vim.v.completed_item.word:match("/$")
			and vim.v.event.complete_type == "files"
			and vim.v.event.reason == "accept"
		then
			simulate_keypress("<C-x><C-f>")
		end
	end,
})
