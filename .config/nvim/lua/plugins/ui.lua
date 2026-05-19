return {
	-- Colorschemes
	{ "Mofiqul/vscode.nvim", lazy = true },
	{ "realbucksavage/riderdark.vim", lazy = true },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true },
	{ "thedenisnikulin/vim-cyberpunk", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "slugbyte/lackluster.nvim", lazy = true },
	{ "projekt0n/github-nvim-theme", lazy = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},


	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.icons",
		},
		opts = {
			-- This ensures render-markdown specifically looks for mini.icons
			render_modes = true,
			heading = {
				border = true,
				sign = false,
				icons = { "", "", "", "", "", "" },
				signs = { "", "", "", "", "", "" },
			},
			indent = { enabled = true },
			anti_conceal = { enabled = true },
		},
	},

	-- Icons
	{
		"echasnovski/mini.icons",
		lazy = false, -- Load early so it can mock devicons for other plugins
		opts = {},
		init = function()
			-- This line is the "magic": it redirects calls from
			-- nvim-web-devicons to mini.icons automatically.
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
