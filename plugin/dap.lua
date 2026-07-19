vim.pack.add({
	gh("mfussenegger/nvim-dap"),
})

local dap = require("dap")

-- Keymaps

vim.keymap.set("n", "<leader>dt", function()
	dap.toggle_breakpoint()
end)

vim.keymap.set("n", "<leader>dc", function()
	dap.continue()
end)

vim.keymap.set("n", "<leader>di", function()
	dap.step_into()
end)

vim.keymap.set("n", "<leader>do", function()
	dap.step_over()
end)

vim.keymap.set("n", "<leader>du", function()
	dap.step_out()
end)

vim.keymap.set("n", "<leader>dr", function()
	dap.repl.open()
end)

vim.keymap.set("n", "<leader>dl", function()
	dap.run_last()
end)

vim.keymap.set("n", "<leader>dq", function()
	dap.terminate()
end)

vim.keymap.set("n", "<leader>db", function()
	dap.list_breakpoints()
end)

vim.keymap.set("n", "<leader>de", function()
	dap.set_exception_breakpoints({ "all" })
end)

-- Adapters

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/js-debug-adapter",
		args = { "${port}" },
	},
}

-- Configurations

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "npm test",
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
