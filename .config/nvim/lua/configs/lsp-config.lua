local lsp_zero = require('lsp-zero')
local fzf_lua = require('fzf-lua')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gr", function()
        fzf_lua.lsp_references({
            winopts = {
                height = 0.8,
                width = 0.9,
                preview = {
                    hidden = 'nohidden',
                    vertical = 'up:50%',
                },
            },
        })
    end, opts)

    vim.keymap.set("n", "<leader>fs", function()
        fzf_lua.lsp_document_symbols({
            winopts = {
                height = 0.5,
                width = 0.4,
                preview = {
                    hidden = 'hidden',
                    vertical = 'up:20%',
                },
            },
        })
    end, opts)

    vim.keymap.set("n", "<leader>ws", function()
        fzf_lua.lsp_workspace_symbols({
            winopts = {
                height = 0.8,
                width = 0.9,
                preview = {
                    hidden = 'hidden',
                    vertical = 'up:60%',
                },
            },
        })
    end, opts)
    --code actions
    vim.keymap.set("n", "<leader>ca", function()
        fzf_lua.lsp_code_actions({
            winopts = {
                height = 0.3,
                width = 0.3,
                preview = {
                    hidden = 'hidden',
                    vertical = 'up:60%',
                },
                -- Position at the cursor
                relative = 'cursor',
                row = 1,
                col = 0,

            },
        })
    end, opts)
end)


-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        require 'lspconfig'.csharp_ls.setup {},
        require 'lspconfig'.gopls.setup {},
        require 'lspconfig'.tsserver.setup {},
        require 'lspconfig'.lua_ls.setup {}
    },
})
