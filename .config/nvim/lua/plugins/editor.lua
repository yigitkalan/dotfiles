return {

    -- FZF Lua
    {
        "ibhagwan/fzf-lua",
        dependencies = {"mini.icons"},
        opts = {file_icons = "mini"},
        lazy = false,
        keys = {
            {"<leader>pf", "<cmd>FzfLua files<cr>", desc = "Find Files"},
            {"<leader>pg", "<cmd>FzfLua live_grep<cr>", desc = "Grep"},
            {"<leader>r", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files"},
            {"<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git Status"},
            {"<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git Commits"},
            -- LSP Pickers (Replaces Snacks.picker.lsp_...)
            {"gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Goto Definition"},
            {"gr", "<cmd>FzfLua lsp_references<cr>", desc = "References"},
            {
                "gi",
                "<cmd>FzfLua lsp_implementations<cr>",
                desc = "Implementations"
            }, {
                "<leader>fs",
                "<cmd>FzfLua lsp_document_symbols<cr>",
                desc = "Document Symbols"
            }, {
                "<leader>ws",
                "<cmd>FzfLua lsp_live_workspace_symbols<cr>",
                desc = "Workspace Symbols"
            },
            {
                "<leader>wd",
                "<cmd>FzfLua diagnostics_document<cr>",
                desc = "Diagnostics"
            }
        }
    }, {
        "stevearc/oil.nvim",
        dependencies = {"echasnovski/mini.icons"},
        lazy = false,
        keys = {
            {
                "<leader>q",
                function()
                    if vim.bo.filetype == "oil" then
                        require("oil").close()
                    else
                        require("oil").open()
                    end
                end,
                desc = "Toggle Oil"
            }
        },
        config = function()
            require("oil").setup({default_file_explorer = true})
        end
    }, {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            -- Exact Helix 'gw' motion
            {
                "gw",
                mode = {"n", "x", "o"},
                function() require("flash").jump() end,
                desc = "Flash Jump"
            }, -- Capital GW for the visual node selection
            {
                "gW",
                mode = {"n", "x", "o"},
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter Selection"
            }
        }
    }, -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        config = function() require("gitsigns").setup() end,
        keys = {
            {"]c", ":Gitsigns next_hunk<cr>", desc = "Next Hunk"},
            {"[c", ":Gitsigns prev_hunk<cr>", desc = "Prev Hunk"},
            {"<leader>hp", ":Gitsigns preview_hunk<cr>", desc = "Preview Hunk"},
            {"<leader>hs", ":Gitsigns stage_hunk<cr>", desc = "Stage Hunk"},
            {
                "<leader>hu",
                ":Gitsigns undo_stage_hunk<cr>",
                desc = "Undo Stage Hunk"
            }, {"<leader>hr", ":Gitsigns reset_hunk<cr>", desc = "Reset Hunk"},
            {
                "<leader>bt",
                ":Gitsigns toggle_current_line_blame<cr>",
                desc = "Toggle Blame"
            }
        }
    }, -- Fugitive
    {"tpope/vim-fugitive", cmd = "Git"}, -- Tmux Navigator
    {
        "christoomey/vim-tmux-navigator",
        keys = {
            {"<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux Left"},
            {"<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux Down"},
            {"<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux Up"},
            {"<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux Right"}
        }
    }, -- Conform
    {
        "stevearc/conform.nvim",
        event = {"BufReadPre", "BufNewFile"},
        config = function()
            local conform = require("conform")

            -- 1. DEFINE YOUR FORMATTERS
            conform.setup({
                formatters_by_ft = {
                    lua = {"stylua"},
                    python = {"isort", "black"},
                    javascript = {
                        "prettierd",
                        "prettier",
                        stop_after_first = true
                    },
                    typescript = {
                        "prettierd",
                        "prettier",
                        stop_after_first = true
                    },
                    markdown = {
                        "prettierd",
                        "prettier",
                        stop_after_first = true
                    }
                },

                -- 2. FORMAT ON SAVE (Conditional)
                format_on_save = function(bufnr)
                    -- Disable if a global or buffer-local variable is set
                    if vim.g.disable_autoformat or
                        vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return {timeout_ms = 500, lsp_fallback = true}
                end
            })

            -- 3. KEYMAP: ALT + F to format manually
            -- <M-f> stands for Meta (Alt) + f
            vim.keymap.set({"n", "v"}, "<A-f>", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500
                })
            end, {desc = "Format file or range"})

            -- 4. TOGGLE COMMANDS (Bonus)
            -- Create commands to easily toggle formatting without restarting
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    vim.b.disable_autoformat = true -- Disable for this buffer only
                else
                    vim.g.disable_autoformat = true -- Disable globally
                end
            end, {desc = "Disable autoformat-on-save", bang = true})

            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {desc = "Re-enable autoformat-on-save"})
        end
    }
}
