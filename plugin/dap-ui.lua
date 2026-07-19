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
