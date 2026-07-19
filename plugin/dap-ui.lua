vim.pack.add({
	gh("mfussenegger/nvim-dap"),
	gh("rcarriga/nvim-dap-ui"),
	gh("nvim-neotest/nvim-nio"),
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
-- 	ui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
-- 	ui.close()
-- end
--

vim.api.nvim_create_user_command("DapUiOpen", function(opts)
	dapui.open()
end, { desc = "Open the DAP UI" })

vim.api.nvim_create_user_command("DapUiClose", function(opts)
	dapui.close()
end, { desc = "Close the DAP UI" })
