-- This file can be loaded by calling `lua require('plugins')` from your init.vimplug

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'


    ---------------------------------------------visual stuff
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'jiangmiao/auto-pairs'
    use 'ryanoasis/vim-devicons'
    use('nvim-treesitter/nvim-treesitter', { run = 'TSUpdate' })
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter-context'

    use { 'NvChad/nvim-colorizer.lua',
        require 'colorizer'.setup {
            user_default_options = {
                names = true,
            }
        }

    }
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    }






    ------------------------------------------------------core
    ---------------coc and autocompletion
    use { 'neoclide/coc.nvim', branch = 'release' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { 'nvim-lua/plenary.nvim' }

    }

    use { 'vim-test/vim-test' }


    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }




    ------------------------------------------------utils
    use "akinsho/toggleterm.nvim"

    use "github/copilot.vim"

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use 'mg979/vim-visual-multi'
    use 'honza/vim-snippets'

    ----------------------------- tpope
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'




    ----------------------------------------------- colorschemes
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
