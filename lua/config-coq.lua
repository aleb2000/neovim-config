vim.g.coq_settings = {
	keymap = {
		recommended = true
	},
	auto_start = 'shut-up',
	display = {
		pum = { fast_close = false },
		icons = { mode = 'long' }
	},
	clients = {
		tmux = { enabled = false }
	}
}
require('coq')

require('coq_3p') {
	{src = 'copilot', short_name = 'COP', accept_key = '<c-f>'}
}
