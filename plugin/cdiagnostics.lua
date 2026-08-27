--- Commands to add diagnostics to lists
vim.api.nvim_create_user_command("CDiagnostics", function(args)
	local diagnostic_type = args.args:upper()
	if diagnostic_type == "ERROR" then
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
	elseif diagnostic_type == "WARN" then
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
	elseif diagnostic_type == "HINT" then
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
	elseif diagnostic_type == "INFO" then
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

vim.api.nvim_create_user_command("LDiagnostics", function(args)
	local diagnostic_type = args.args:upper()
	if diagnostic_type == "ERROR" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
	elseif diagnostic_type == "WARN" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.WARN })
	elseif diagnostic_type == "HINT" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.HINT })
	elseif diagnostic_type == "INFO" then
		vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.INFO })
	else
		vim.diagnostic.setloclist({})
	end
end, {
	desc = "Adds lsp diagnostic to the Locations list",
	complete = function()
		return { "ERROR", "WARN", "HINT", "INFO" }
	end,
	nargs = "?",
})
