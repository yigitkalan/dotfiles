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

	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "iceberg_dark",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = {},
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},

	-- Icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- UI Improvements (Snacks.nvim replaces dressing, notify, etc.)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			input = {
				enabled = true,
			},
			picker = { enabled = true },
			notifier = { enabled = true },
			terminal = { enabled = true },
			explorer = { enabled = true }, -- The "Picker-style" tree explorer
			indent = {
				enabled = true,
				animate = {
					enabled = false,
				},
			}, -- Better indent guides/scope
			dashboard = {
				enabled = true,
				sections = {
					-- Main Header (Static)
					{ section = "header" },

					-- Navigation Menu (Left/Center)
					{ section = "keys", gap = 1, padding = 2 },

					-- Git Intel (Right Pane - Only shows if in a Git Repo)
					{
						pane = 2,
						section = "terminal",
						title = "󰊢 Git Status",
						cmd = "git status --short",
						height = 10,
						padding = 1,
						ttl = 5,
						-- This ensures it doesn't throw errors in non-git folders
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
					},
					{
						pane = 2,
						section = "terminal",
						title = "󱖫 Recent Commits",
						cmd = "git log -n 5 --oneline --color",
						height = 8,
						padding = 1,
						ttl = 60,
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
					},

					-- Footer Info
					{ section = "startup" },
				},
				preset = {
					header = [[
 ███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
 ████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
 ██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
 ██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
 ██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
 ╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
						{ icon = " ", key = "g", desc = "Live Grep", action = ":lua Snacks.picker.grep()" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
						{ icon = "󰊢 ", key = "v", desc = "LazyGit", action = ":lua Snacks.lazygit()" },
						{
							icon = " ",
							key = "s",
							desc = "Settings",
							action = ":lua Snacks.explorer({cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
		keys = {
			{
				"<leader>u",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo History",
			},
			{
				"<leader>pf",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>pg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<A-\\>",
				function()
					Snacks.terminal.toggle()
				end,
				mode = { "n", "t" }, -- This is the magic part
				desc = "Toggle Terminal",
			},

			{
				"<leader>q",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			-- GITHUB (Team Workflow)
			{
				"<leader>gi",
				function()
					Snacks.picker.gh_issue()
				end,
				desc = "GitHub Issues (open)",
			},
			{
				"<leader>gI",
				function()
					Snacks.picker.gh_issue({ state = "all" })
				end,
				desc = "GitHub Issues (all)",
			},
			{
				"<leader>gp",
				function()
					Snacks.picker.gh_pr()
				end,
				desc = "GitHub Pull Requests (open)",
			},
			{
				"<leader>gP",
				function()
					Snacks.picker.gh_pr({ state = "all" })
				end,
				desc = "GitHub Pull Requests (all)",
			},
		},
	},

	{
		"Bekaboo/dropbar.nvim",
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
	},

	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			render = "background",
			enable_named_colors = true,
			enable_tailwind = true,
		},
	},
}
