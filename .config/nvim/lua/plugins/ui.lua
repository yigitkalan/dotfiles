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
		dependencies = { "mini.icons" },
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

	-- UI Improvements (Snacks.nvim replaces dressing, notify, etc.)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			input = {
				enabled = true,
			},
			statuscolumn = {
				enabled = true,
				left = { "mark", "sign" }, -- Shows marks and signs (like LSP warnings)
				right = { "fold", "git" }, -- Shows fold indicators and git signs
				folds = {
					open = true, -- Show icons for open folds (instead of numbers)
					git_hl = true, -- Colors the fold icons based on git status
				},
			},
			picker = { enabled = true },
			notifier = { enabled = true },
			terminal = { enabled = true },
			explorer = {
				enabled = true,
				replace_netrw = true, -- Crucial for 'nvim .' to work
			}, -- The "Picker-style" tree explorer
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
							action = function()
								local config_path = vim.fn.stdpath("config")
								-- 1. Change Neovim's actual working directory
								vim.api.nvim_set_current_dir(config_path)
								-- 2. Open the Snacks explorer in that new directory
								Snacks.explorer({ cwd = config_path })
							end,
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
		config = function(_, opts)
			require("snacks").setup(opts)

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					local arg = vim.fn.argv(0)
					if arg and vim.fn.isdirectory(arg) == 1 then
						vim.schedule(function()
							Snacks.explorer({ cwd = arg })
						end)
					end
				end,
			})
		end,
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
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.icons",
		},
		opts = {
			-- This ensures render-markdown specifically looks for mini.icons
			render_modes = true,
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
