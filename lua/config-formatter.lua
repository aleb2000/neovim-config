local util = require("formatter.util")

-- Uncomment to enable formatting on save
-- vim.cmd([[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost * FormatWrite
-- augroup END
-- ]])

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		c = { require("formatter.filetypes.c").clangformat },
		cpp = { require("formatter.filetypes.c").clangformat },
		java = { require("formatter.filetypes.java").clangformat },
		rust = { require("formatter.filetypes.rust").rustfmt },
		lua = { require("formatter.filetypes.lua").stylua },
		python = { require("formatter.filetypes.python").black },
		html = { require("formatter.filetypes.html").prettierd },
		json = { require("formatter.filetypes.json").prettierd },
		javascript = { require("formatter.filetypes.javascript").prettierd },
	},
})
