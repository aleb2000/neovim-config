-- Globals
vim.g.mapleader = ';'
vim.opt.scl = 'yes'

-- Options
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.mouse = 'a'
vim.opt.encoding = 'UTF-8'
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.wildmode = 'list:longest,list:full'

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.cmd [[
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
]]

require('plugins')

vim.cmd [[colorscheme tokyonight]]
