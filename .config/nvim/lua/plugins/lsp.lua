return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- GDScript
			vim.lsp.config("gdscript", {
				cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
				on_attach = function(client)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
			vim.lsp.enable("gdscript")

			require("mason-lspconfig").setup({ ensure_installed = {} })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "gdscript",
				callback = function()
					local addr
					if vim.fn.has("win32") == 1 then
						addr = "127.0.0.1:55432"
					else
						local pipe_path = "/tmp/godot.pipe"
						if vim.uv.fs_stat(pipe_path) then
							os.remove(pipe_path)
						end
						addr = pipe_path
					end

					-- Only start if it's not already running
					local ok, err = pcall(vim.fn.serverstart, addr)
					if ok then
						vim.notify("Godot server ready: " .. addr, vim.log.levels.INFO)
					end
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local opts = { buffer = ev.buf }

					-- NATIVE LSP ACTIONS (Keep these!)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ max_width = 80, border = "single" })
					end, opts)
					vim.keymap.set("n", "<leader>ca", function()
						require("fzf-lua").lsp_code_actions()
					end, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to Declaration (different from definition)
					vim.keymap.set("i", "<c-s>", function()
						vim.lsp.buf.signature_help({ border = "single" })
					end, opts)
					vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "x" }, "<a-F>", function()
						vim.lsp.buf.format({ async = true })
					end, opts)

					-- DIAGNOSTICS (Keep these!)
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
				end,
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
			})
		end,
	}, -- { "seblyng/roslyn.nvim", ft = "cs", opts = {} },
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
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
			require("godotdev").setup({
				formatter = false,
				-- formatter = "gdscript-formatter",
				-- formatter_cmd = { "gdscript-formatter" },
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<A-l>", -- Alt + l to accept suggestion
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
