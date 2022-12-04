vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use) -- Packer can manage itself
	use 'wbthomason/packer.nvim'
	-- Status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- Treesitter
	use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

	-- Colors theme
	use 'bluz71/vim-nightfly-colors'
	use 'rakr/vim-one'
	use 'lunarvim/Onedarker.nvim' use 'morhetz/gruvbox'
	use 'folke/tokyonight.nvim'

	-- Devicons
	use 'nvim-tree/nvim-web-devicons'

	-- Code completion
	use { 'ms-jpq/coq_nvim', branch = 'coq' }

	use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

	use { 'ms-jpq/coq.thirdparty', branch = '3p' }

	-- LSP
	use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig'
	}

	use 'weilbith/nvim-code-action-menu'

	use 'kosayoda/nvim-lightbulb'

	use 'jubnzv/virtual-types.nvim'

	-- Indent lines
	use "lukas-reineke/indent-blankline.nvim"

	-- Copilot
	use 'github/copilot.vim'

	-- File explorer
	use { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' }

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use { 'nvim-telescope/telescope-fzf-native.nvim' , run = 'make' }

	-- Git
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}

	-- Misc
	use 'NvChad/nvim-colorizer.lua'
	use 'glepnir/dashboard-nvim'
	use 'petertriho/nvim-scrollbar'

end)
-- Config plugins 
require('config-lualine')
require('nvim-web-devicons').setup {
	color_icons = true;
	default = true; -- idk what this does
}
require('config-treesitter')
require('config-tokyonight')
require('config-coq')
require('config-lsp')
require('config-indent')
require('config-chadtree')
require('colorizer').setup {}
require('config-dashboard')
require('config-telescope')
require("scrollbar").setup()
