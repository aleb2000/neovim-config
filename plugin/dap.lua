vim.pack.add({
	GH("mfussenegger/nvim-dap"),
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

local npm_test_scripts = {
	"test",
	"test:integration:run",
	"test:loud",
	"test:integration:run:loud",
}

local function npm_test_config(script, current_file_only)
	local runtime_args = { "run", script, "--", "--runInBand" }
	local name = "npm " .. script
	if current_file_only then
		name = name .. " - Current File"
		table.insert(runtime_args, "${file}")
	end

	return {
		type = "pwa-node",
		request = "launch",
		name = name,
		runtimeExecutable = "npm",
		runtimeArgs = runtime_args,
		rootPath = "${workspaceFolder}",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		internalConsoleOptions = "neverOpen",
		sourceMaps = true,
		resolveSourceMapLocations = {
			"${workspaceFolder}/**",
			"!**/node_modules/**",
		},
	}
end

local npm_test_configs = {}
for _, script in ipairs(npm_test_scripts) do
	table.insert(npm_test_configs, npm_test_config(script, false))
	table.insert(npm_test_configs, npm_test_config(script, true))
end

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = npm_test_configs
end
