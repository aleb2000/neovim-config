local util = require("formatter.util")

vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])

local function clang_format()
	return {
		exe = "clang-format",
		args = {
			"-assume-filename",
			util.escape_path(util.get_current_buffer_file_name()),
			'"--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Always, PointerAlignment: Left, SpaceAfterCStyleCast: true, IndentCaseLabels: true}"',
		},
		stdin = true,
		try_node_modules = true,
	}
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		c = { clang_format },
		java = { clang_format },
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--edition 2021" },
					stdin = true,
				}
			end,
		},
		lua = { require("formatter.filetypes.lua").stylua },
		python = {
			function()
				return {
					exe = "black",
					args = {
						"--quiet",
						"-",
					},
					stdin = true,
				}
			end,
		},
	},
})
