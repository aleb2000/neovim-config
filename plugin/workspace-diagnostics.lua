vim.pack.add({
	gh("artemave/workspace-diagnostics.nvim"),
})

local workspace_diagnostics = require("workspace-diagnostics")

local function populate_workspace_diagnostics(lsp_client, bufnr)
	-- some clients support workspace diagnostics natively
	if lsp_client:supports_method("workspace/diagnostic", bufnr) then
		vim.lsp.buf.workspace_diagnostics({ client_id = lsp_client.id })
	else
		workspace_diagnostics.populate_workspace_diagnostics(lsp_client, bufnr)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfigWorkspaceDiagnostics", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		populate_workspace_diagnostics(client, ev.buf)
	end,
})

-- Commands to add diagnostics to lists
vim.api.nvim_create_user_command("QFLspDiagnostics", function(args)
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		populate_workspace_diagnostics(client, bufnr)
	end

	if args.args == "ERROR" then
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
	elseif args.args == "WARN" then
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
	elseif args.args == "HINT" then
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
	elseif args.args == "INFO" then
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.INFO })
	else
		vim.diagnostic.setqflist({})
	end
end, {
	desc = "Adds lsp diagnostic to the Quickfix list",
	complete = function()
		return { "ERROR", "WARN", "HINT", "INFO" }
	end,
	nargs = "?",
})

vim.api.nvim_create_user_command("LocLspDiagnostics", function(args)
	-- local bufnr = vim.api.nvim_get_current_buf()
	-- local clients = vim.lsp.get_clients({ bufnr = bufnr })
	-- for _, client in ipairs(clients) do
	-- 	populate_workspace_diagnostics(client, bufnr)
	-- end
	--
	if args.args == "ERROR" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
	elseif args.args == "WARN" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.WARN })
	elseif args.args == "HINT" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.HINT })
	elseif args.args == "INFO" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.INFO })
	else
		vim.diagnostic.setloclist({})
	end
end, {
	desc = "Adds lsp diagnostic to the Quickfix list",
	complete = function()
		return { "ERROR", "WARN", "HINT", "INFO" }
	end,
	nargs = "?",
})
