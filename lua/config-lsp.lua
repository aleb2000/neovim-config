-- Mason
require("mason").setup()
require("mason-lspconfig").setup()


-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function (server_name) -- default handler
		require("lspconfig")[server_name].setup {
			on_attach=require'virtualtypes'.on_attach,
			capabilities = capabilities
		}
	end,

	['lua_ls'] = function (server_name) -- dedicated handler
		require("lspconfig")[server_name].setup {
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT',
						path = vim.split(package.path, ';'),
					},
					diagnostics = {
						globals = {'vim'},
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
			capabilities = capabilities
		}
	end,
}

local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>', bufopts)

require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

--vim.cmd [[hi LspDiagnosticsVirtualTextError guifg=#db4b4b gui=bold,italic,underline]]
--vim.cmd [[hi DiagnosticsWarn guifg=orange gui=bold,italic,underline]]
--vim.cmd [[hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline]]
--vim.cmd [[hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline]]

require "lsp_signature".setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded"
	}
})
