return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			-- In your lspconfig file
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- New Neovim 0.11 way to define the Godot config
			vim.lsp.config("gdscript", {
				-- MATCH THIS to your Godot Editor settings (TCP vs Pipe)
				cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- Disable semantic tokens to fix the "white text" issue
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})

			-- Actually start the client
			vim.lsp.enable("gdscript")

			-- ... rest of your mason-lspconfig and LspAttach autocmds
			-- Keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "gd", function()
						Snacks.picker.lsp_definitions()
					end, opts)
					vim.keymap.set("n", "gr", function()
						Snacks.picker.lsp_references()
					end, opts)
					vim.keymap.set("n", "gi", function()
						Snacks.picker.lsp_implementations()
					end, opts)
					vim.keymap.set("n", "gt", function()
						Snacks.picker.lsp_type_definitions()
					end, opts)

					vim.keymap.set("n", "<leader>fs", function()
						Snacks.picker.lsp_symbols()
					end, opts)
					vim.keymap.set("n", "<leader>ws", function()
						Snacks.picker.lsp_workspace_symbols()
					end, opts)
					vim.keymap.set("n", "<leader>wd", function()
						Snacks.picker.diagnostics()
					end, opts) -- Changed to setqflist or open_float
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded", max_width = 80 })
					end, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("i", "<c-s>", function()
						vim.lsp.buf.signature_help({ border = "rounded" })
					end, opts)
					vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "x" }, "<a-F>", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
				end,
			})

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- Add servers if needed
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({ capabilities = capabilities })
					end,
					-- Omnisharp is handled by easy-dotnet or not needed if using Roslyn
					-- ["omnisharp"] = function() ... end
				},
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "easy-dotnet" },
				}),
				window = {
					-- This creates the border for the main completion menu
					completion = cmp.config.window.bordered({
						border = "rounded", -- Options: "single", "double", "shadow", "rounded"
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					}),
					-- This creates the border for the documentation hover window
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					}),
				},
			})
		end,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
				ui = { border = "rounded" },
			})
		end,
	},

	-- { "seblyng/roslyn.nvim", ft = "cs", opts = {} },

	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		ft = { "cs", "vb", "csproj", "sln" },
		config = function()
			require("easy-dotnet").setup({ picker = "telescope" })
		end,
	},
	{
		"Mathijs-Bakker/godotdev.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui", -- Adds a nice UI for the debugger
			"nvim-telescope/telescope.nvim", -- For your path completions
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("godotdev").setup({})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				-- Since you don't use nvim-cmp, you MUST enable these:
				suggestion = {
					enabled = true,
					auto_trigger = true, -- Suggests as you type
					debounce = 75,
					keymap = {
						accept = "<M-l>", -- Alt + l to accept suggestion
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-p>", -- Alt + p to open the full panel
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
			})
		end,
	},
}
