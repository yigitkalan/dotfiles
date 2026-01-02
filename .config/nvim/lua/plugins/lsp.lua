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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- NEW WAY: Instead of require('lspconfig').gdscript.setup()
			-- We use the built-in vim.lsp.config table
			if vim.lsp.config then
				vim.lsp.config.gdscript = {
					capabilities = capabilities,
				}
			end

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
					vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, opts) -- Changed to setqflist or open_float
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

			-- Godot
			-- lspconfig.gdscript.setup({ capabilities = capabilities })
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
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
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
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
		},
		config = function()
			require("godotdev").setup({
				godot_path = "godot", -- Ensure this is in your PATH
			})
		end,
	},
}
