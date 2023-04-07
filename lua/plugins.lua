vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use) -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end
    }

    -- Colors theme
    use 'bluz71/vim-nightfly-colors'
    use 'rakr/vim-one'
    use 'lunarvim/Onedarker.nvim'
    use 'morhetz/gruvbox'
    use 'folke/tokyonight.nvim'

    -- Devicons
    use 'nvim-tree/nvim-web-devicons'

    -- LSP
    use {
        'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig'
    }

    use 'weilbith/nvim-code-action-menu'

    use 'kosayoda/nvim-lightbulb'
    use 'jubnzv/virtual-types.nvim'

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }

    use {"ray-x/lsp_signature.nvim"}

    -- Code completion
    -- Thanks https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
            'hrsh7th/cmp-nvim-lua',
            'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
            'f3fora/cmp-spell', 'hrsh7th/cmp-emoji', 'honza/vim-snippets'
        }
    }

	-- Snippets
	use {
		'hrsh7th/vim-vsnip',
		requires = {
			'hrsh7th/vim-vsnip-integ'
		}
	}
	use 'honza/vim-snippets'
	use "rafamadriz/friendly-snippets"

    -- Indent lines
    use "lukas-reineke/indent-blankline.nvim"

    -- Copilot
    use 'github/copilot.vim'

    -- File explorer
    use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
    }

    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
        end
    }

    -- Misc
    use 'NvChad/nvim-colorizer.lua'
    use 'glepnir/dashboard-nvim'
    use 'petertriho/nvim-scrollbar'
    use 'sbdchd/neoformat'
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
end)

vim.g.copilot_no_tab_map = true

-- Config plugins 
require('config-lualine')
require('nvim-web-devicons').setup {
    color_icons = true,
    default = true -- idk what this does
}
require('config-treesitter')
require('config-tokyonight')
require("config-nvim-cmp")
require('config-lsp')
require('config-indent')
require('config-chadtree')
require('colorizer').setup {}
require('config-dashboard')
require('config-telescope')
require("scrollbar").setup()

-- Trouble keymaps
vim.keymap.set('n', '<leader>tt', '<CMD>TroubleToggle<CR>',
               {noremap = true, silent = true})
vim.keymap.set('n', '<leader>tw',
               '<CMD>TroubleToggle workspace_diagnostics<CR>',
               {noremap = true, silent = true})
vim.keymap.set('n', '<leader>td', '<CMD>TroubleToggle document_diagnostics<CR>',
               {noremap = true, silent = true})
