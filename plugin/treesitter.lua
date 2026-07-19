vim.pack.add({
	gh("nvim-treesitter/nvim-treesitter"),
})

local nvim_treesitter = require("nvim-treesitter")

-- Enable treesitter for available parsers
local function treesitter_start(filetype)
	local lang = vim.treesitter.language.get_lang(filetype)
	if vim.treesitter.language.add(lang) then
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.treesitter.start()
	end
end

-- Automatically start Treesitter for all filetypes, when parsers are already installed
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local filetype = args.match
		treesitter_start(filetype)
		-- Fold method is managed by nvim-origami, uncomment this if you uninstall origami
		-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- vim.wo[0][0].foldmethod = "expr"
	end,
})

-- Update parsers on plugin change
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" then
			nvim_treesitter.update()
		end
	end,
})

vim.api.nvim_create_user_command("TSAuto", function(opts)
	local filetype = vim.bo.filetype
	local lang = vim.treesitter.language.get_lang(filetype)

	-- Treesitter uses its own async-await paradigm for long running operations
	nvim_treesitter.install(lang):await(function(err, result)
		if not result then
			print(err)
		end
		treesitter_start(filetype)
	end)
end, { desc = "Automatically install and start Treesitter for the language of the current buffer" })

vim.api.nvim_create_user_command("TSStart", function(opts)
	local filetype = vim.bo.filetype
	local lang = vim.treesitter.language.get_lang(filetype)
	if not vim.treesitter.language.add(lang) then
		print("Treesitter parser for language '" .. lang .. "' is not installed.")
		return
	end
	treesitter_start(filetype)
end, { desc = "Manually start Treesitter for installed parsers" })
