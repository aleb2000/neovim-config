vim.pack.add({
	gh("neovim/nvim-lspconfig"),
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		local function lsp_keymap_set(method, mode, keymap, callback)
			if client:supports_method(method) then
				local opts = { buffer = ev.buf, remap = false }
				vim.keymap.set(mode, keymap, callback, opts)
			end
		end

		-- textDocument/hover is already enabled by default by nvim (keymap: K)
		lsp_keymap_set("textDocument/declaration", "n", "gD", vim.lsp.buf.declaration)
		lsp_keymap_set("textDocument/definition", "n", "gd", vim.lsp.buf.definition)
		lsp_keymap_set("textDocument/implementation", "n", "gi", vim.lsp.buf.implementation)

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		-- if client:supports_method("textDocument/completion") then
		-- Optional: trigger autocompletion on EVERY keypress. May be slow!
		-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
		-- client.server_capabilities.completionProvider.triggerCharacters = chars
		-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		-- end
	end,
})
