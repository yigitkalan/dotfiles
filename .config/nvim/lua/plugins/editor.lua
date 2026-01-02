return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>pg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
        },
      })
    end,
  },

  -- FZF Lua
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>ht", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Toggle" },
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon Add" },
      { "<a-]>", function() require("harpoon.ui").nav_next() end, desc = "Harpoon Next" },
      { "<a-[>", function() require("harpoon.ui").nav_prev() end, desc = "Harpoon Prev" },
      { "<a-1>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon 1" },
      { "<a-2>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon 2" },
      { "<a-3>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon 3" },
      { "<a-4>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon 4" },
    },
  },

  -- Undotree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    keys = {
      { "]c", ":Gitsigns next_hunk<cr>", desc = "Next Hunk" },
      { "[c", ":Gitsigns prev_hunk<cr>", desc = "Prev Hunk" },
      { "<leader>hp", ":Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      { "<leader>hs", ":Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
      { "<leader>hu", ":Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
      { "<leader>hr", ":Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
      { "<leader>bt", ":Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Blame" },
    },
  },

  -- Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle Terminal" }
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = 'float',
      })
    end,
  },

  -- Fugitive
  { "tpope/vim-fugitive", cmd = "Git" },

  -- Tmux Navigator
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux Left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux Down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux Up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux Right" },
    },
  },
  -- Conform
 {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    -- 1. DEFINE YOUR FORMATTERS
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
      },

      -- 2. FORMAT ON SAVE (Conditional)
      format_on_save = function(bufnr)
        -- Disable if a global or buffer-local variable is set
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    })

    -- 3. KEYMAP: ALT + F to format manually
    -- <M-f> stands for Meta (Alt) + f
    vim.keymap.set({ "n", "v" }, "<A-f>", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range" })

    -- 4. TOGGLE COMMANDS (Bonus)
    -- Create commands to easily toggle formatting without restarting
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true -- Disable for this buffer only
      else
        vim.g.disable_autoformat = true -- Disable globally
      end
    end, { desc = "Disable autoformat-on-save", bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable autoformat-on-save" })
  end,
}
}
