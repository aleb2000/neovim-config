local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use) -- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({
				with_sync = true,
			})
			ts_update()
		end,
	})
	use("windwp/nvim-ts-autotag")

	-- Colors theme
	use("bluz71/vim-nightfly-colors")
	use("rakr/vim-one")
	use("lunarvim/Onedarker.nvim")
	use("morhetz/gruvbox")
	use("folke/tokyonight.nvim")

	-- Devicons
	use("nvim-tree/nvim-web-devicons")

	-- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-lint",
		"rshkarin/mason-nvim-lint",
	})

	use({
		"esmuellert/nvim-eslint",
		config = function()
			require("nvim-eslint").setup({})
		end,
	})

	use({
		"aznhe21/actions-preview.nvim",
	})

	use("kosayoda/nvim-lightbulb")

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	use({ "ray-x/lsp_signature.nvim" })
	use({ "mrcjkb/rustaceanvim" })

	use({
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
	})

	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	})
	use({ "theHamsta/nvim-dap-virtual-text", requires = { "nvim-treesitter/nvim-treesitter" } })

	-- Code completion
	-- Thanks https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"octaltree/cmp-look",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-emoji",
			"honza/vim-snippets",
			"hrsh7th/cmp-cmdline",
		},
	})
	-- Snippets
	use({
		"hrsh7th/vim-vsnip",
		requires = {
			"hrsh7th/vim-vsnip-integ",
		},
	})
	use("honza/vim-snippets")
	use("rafamadriz/friendly-snippets")

	-- Indent lines
	use("lukas-reineke/indent-blankline.nvim")

	-- Copilot
	--use("github/copilot.vim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "stevearc/dressing.nvim" })

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	})

	-- Misc
	use("NvChad/nvim-colorizer.lua")
	-- use("glepnir/dashboard-nvim")
	use("petertriho/nvim-scrollbar")
	use("mhartington/formatter.nvim")
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use("paretje/nvim-man")
	use({
		"themaxmarchuk/tailwindcss-colors.nvim",
	})
	use("szymonwilczek/vim-be-better")
end)

vim.g.copilot_no_tab_map = true
vim.b.copilot_enabled = false
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, { noremap = true })
require("actions-preview").setup()

-- Config plugins
require("config-lualine")
require("nvim-web-devicons").setup({
	color_icons = true,
	default = true, -- idk what this does
})
require("config-treesitter")
require("config-tokyonight")
require("config-nvim-cmp")
require("config-lsp")
require("config-indent")
require("colorizer").setup({})
--require("config-dashboard")
require("config-telescope")
require("scrollbar").setup()
require("config-formatter")
require("tailwindcss-colors").setup()
require("config-dap")

-- Trouble keymaps
vim.keymap.set("n", "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tT", "<CMD>Trouble diagnostics filter.buf=0<CR>", { noremap = true, silent = true })

-- Man
vim.g.nvim_man_default_target = "tab"
