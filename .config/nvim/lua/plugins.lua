-- This file can be loaded by calling `lua require('plugins')` from your init.vimplug

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- tpope
    -- use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    use 'honza/vim-snippets'
    use 'mg979/vim-visual-multi'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }


    --visual stuff
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'jiangmiao/auto-pairs'
    use 'ryanoasis/vim-devicons'
    use ('nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'})
    use "HiPhish/nvim-ts-rainbow2"
    use 'xiyaowong/nvim-transparent'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter-context'
    use {"lukas-reineke/indent-blankline.nvim",
    require("indent_blankline").setup {
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = false,
    }   }
    use {'NvChad/nvim-colorizer.lua',
    require 'colorizer'.setup{
        user_default_options = {
            names = false,
        }
    }   
}

use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
}


use {
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional
    },
}


use 'iamcco/markdown-preview.nvim'

-- coc and autocompletion
use { 'neoclide/coc.nvim', branch='release' }
use 'lervag/vimtex'
use 'OmniSharp/omnisharp-vim'
use 'dense-analysis/ale'

use 'mbbill/undotree'

use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
}


use "akinsho/toggleterm.nvim"

use 'sbdchd/neoformat'


-- colorschemes
use { "catppuccin/nvim", as = "catppuccin" }
use 'folke/tokyonight.nvim'
use({ 'rose-pine/neovim', as = 'rose-pine' })
use "EdenEast/nightfox.nvim" -- Packer
use 'joshdick/onedark.vim'
use 'tomasr/molokai'
use "rebelot/kanagawa.nvim"
use 'NLKNguyen/papercolor-theme'
use 'rafi/awesome-vim-colorschemes'
use({
  'glepnir/zephyr-nvim',
  requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
})


end)
