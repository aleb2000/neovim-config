-- Globals
vim.g.mapleader = " "
vim.o.scl = "yes"

-- Options
vim.o.number = true
vim.o.showmatch = true
vim.o.mouse = "a"
vim.o.mousescroll = "ver:1"
vim.o.encoding = "UTF-8"
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.wildmode = "list:longest,list:full"

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false

vim.cmd([[
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
]])

-- Delete trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function(ev)
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- helper used when adding plugins with vim.pack
function gh(x)
	return "https://github.com/" .. x
end

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	vim.pack.update()
end, { desc = "Update vim.pack packages, perform :write on the confirmation buffer to apply the updates" })
