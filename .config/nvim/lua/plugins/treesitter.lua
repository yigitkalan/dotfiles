return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		priority = 1000,
		config = function()
			-- Enable highlighting via autocommand
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" }, -- or list specific filetypes
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
			-- Install parsers (this replaces ensure_installed)
			require("nvim-treesitter").install({
				"c_sharp",
				"python",
				"gdscript",
				"godot_resource",
				"lua",
				"vim",
				"vimdoc", -- Required for Neovim help docs
				"sql",
				"javascript",
				"typescript",
				"html",
				"css",
			})
		end,
	},

	-- Rainbow Delimiters (Replacement for p00f/nvim-ts-rainbow)
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		config = function()
			require("Comment").setup()
		end,
	},
}
