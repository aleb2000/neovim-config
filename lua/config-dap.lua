local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

-- Dap Virtual Text
dap_virtual_text.setup()

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/js-debug-adapter",
		args = { "${port}" },
	},
}

-- dap.adapters["node2"] = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = {
-- 		os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js",
-- 	},
-- }

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test",
			-- trace = true, -- include debugger info
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test",
				"--",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test - Current File",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test",
				"--",
				"--runInBand",
				"${file}",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test:integration",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test:integration:run",
				"--",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test:integration - Current File",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test:integration:run",
				"--",
				"--runInBand",
				"${file}",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},

		-- Loud versions
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test:loud",
			-- trace = true, -- include debugger info
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test:loud",
				"--",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test:loud - Current File",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test:loud",
				"--",
				"--runInBand",
				"${file}",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test:integration:loud",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test:integration:run:loud",
				"--",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test:integration:loud - Current File",
			runtimeExecutable = "npm",
			runtimeArgs = {
				"run",
				"test:integration:run:loud",
				"--",
				"--runInBand",
				"${file}",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
	}
end

-- Dap UI

ui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
-- 	ui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
-- 	ui.close()
-- end

-- Dap Keymaps

vim.keymap.set("n", "<leader>dt", function()
	require("dap").toggle_breakpoint()
end)

vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end)

vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end)

vim.keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end)

vim.keymap.set("n", "<leader>du", function()
	require("dap").step_out()
end)

vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end)

vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end)

vim.keymap.set("n", "<leader>dq", function()
	require("dap").terminate()
	require("dapui").close()
	require("nvim-dap-virtual-text").toggle()
end)

vim.keymap.set("n", "<leader>db", function()
	require("dap").list_breakpoints()
end)

vim.keymap.set("n", "<leader>de", function()
	require("dap").set_exception_breakpoints({ "all" })
end)
