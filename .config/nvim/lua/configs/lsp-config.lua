local lsp_zero = require('lsp-zero')
local fzf_lua = require('fzf-lua')

fzf_lua.setup({
    keymap = {
        fzf = {
            ["tab"] = "down",
            ["shift-tab"] = "up",
        },
    },
})

local function set_fzf_keymaps(bufnr)
    local opts = { buffer = bufnr, remap = false }
    local fzf_commands = {
        { key = "gd",         cmd = "lsp_definitions" },
        { key = "gr",         cmd = "lsp_references" },
        { key = "gi",         cmd = "lsp_implementations" },
        { key = "gt",         cmd = "lsp_typedefs" },
        { key = "<leader>fs", cmd = "lsp_document_symbols" },
        { key = "<leader>ws", cmd = "lsp_workspace_symbols" },
        { key = "<leader>ac", cmd = "lsp_code_actions" },
    }

    for _, mapping in ipairs(fzf_commands) do
        vim.keymap.set("n", mapping.key, function()
            fzf_lua[mapping.cmd]({
                jump_to_single_result = true,
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
    end
end

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    -- lsp_zero.default_keymaps({ buffer = bufnr })
    require "lsp_signature".setup(client)

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local opts = { buffer = event.buf }
            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<leader>re', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({ 'n', 'x' }, '<a-f>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
            vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
            vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

            require("lsp_signature").on_attach({
                -- ... setup options here ...
            }, bufnr)
        end

    })
    local opts = { buffer = bufnr, remap = false }
    set_fzf_keymaps(bufnr)


    local has_omnisharp = false
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, c in ipairs(clients) do
        if c.name == "omnisharp" then
            has_omnisharp = true
            break
        end
    end
    -- Custom keybindings for Omnisharp
    if has_omnisharp then
        vim.keymap.set('n', 'gd', '<cmd>lua require("omnisharp_extended").lsp_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua require("omnisharp_extended").lsp_references()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua require("omnisharp_extended").lsp_implementation()<cr>', opts)
        vim.keymap.set('n', 'gt', '<cmd>lua require("omnisharp_extended").lsp_type_definition()<cr>', opts)
    end
end)


