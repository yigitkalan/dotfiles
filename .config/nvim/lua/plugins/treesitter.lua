return {
	{
	"nvim-treesitter/nvim-treesitter",
        branch = "main", 
        build = ":TSUpdate",
        config = function()
            local install = require("nvim-treesitter.install")
            
            -- Force GCC and disable the fallback to cl.exe
            install.compilers = { "gcc" }
            install.prefer_git = false -- Sometimes helps Windows pathing issues

            local ts = require("nvim-treesitter")
            ts.setup({})

            ts.install({
                "c_sharp", "python", "gdscript", "godot_resource",
                "lua", "vim", "vimdoc", "sql", "javascript",
                "typescript", "html", "css",
            })

            -- Highlighting
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
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
