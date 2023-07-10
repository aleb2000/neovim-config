-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- Set up lspconfig.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local server_settings = {
	tailwindcss = {
		tailwindCSS = {
			experimental = {
				classRegex = { 'class: "(.*)"' },
			},
			includeLanguages = {
				rust = "html",
			},
		},
	},
	lua_ls = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(server_settings),
})

mason_lspconfig.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			settings = server_settings[server_name],
		})
	end,
	["tailwindcss"] = function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			settings = server_settings[server_name],
			init_options = {
				userLanguages = {
					rust = "html",
				},
			},
			filetypes = {
				"css",
				"scss",
				"sass",
				"postcss",
				"html",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
				"vue",
				"rust",
			},
		})
	end,
})

local bufopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ca", ":CodeActionMenu<CR>", bufopts)

require("nvim-lightbulb").setup({ autocmd = { enabled = true } })

-- vim.cmd [[hi LspDiagnosticsVirtualTextError guifg=#db4b4b gui=bold,italic,underline]]
-- vim.cmd [[hi DiagnosticsWarn guifg=orange gui=bold,italic,underline]]
-- vim.cmd [[hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline]]
-- vim.cmd [[hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline]]

require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = { border = "rounded" },
})

-- Inlay hints
local rt = require("rust-tools")

rt.setup({
	tools = {
		inlay_hints = { auto = true },
	},
	server = {
		on_attach = function(c, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
		end,
	},
})
rt.inlay_hints.enable()
