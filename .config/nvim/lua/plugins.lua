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
    use('nvim-treesitter/nvim-treesitter', { run = 'TSUpdate' })
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'NvChad/nvim-colorizer.lua'

    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    }
    use { "onsails/lspkind.nvim" }
    use({
        'Bekaboo/dropbar.nvim',
        requires = {
            'nvim-telescope/telescope-fzf-native.nvim'
        }
    })

    use { 'stevearc/dressing.nvim' }

    ------------------------------------------------------core
    ---------------coc and autocompletion
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    -- for metadata definitions etc...
    use { 'Hoffs/omnisharp-extended-lsp.nvim' }

    use { 'habamax/vim-godot'}

    use {
        'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }


    ------------------------------------------------utils
    use "christoomey/vim-tmux-navigator"
    use "akinsho/toggleterm.nvim"

    use "SirVer/ultisnips"

    use "github/copilot.vim"

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use 'honza/vim-snippets'

    use 'ThePrimeagen/harpoon'

    use 'mbbill/undotree'

    use 'tpope/vim-fugitive'

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    use({
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    })
    ----------------------------------------------- colorschemes
    use { 'nyoom-engineering/oxocarbon.nvim' }
    use 'thedenisnikulin/vim-cyberpunk'
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'folke/tokyonight.nvim'
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use "rebelot/kanagawa.nvim"
    use "slugbyte/lackluster.nvim"
    use({ 'projekt0n/github-nvim-theme' })
end)
