local lsp_zero = require('lsp-zero')
local builtin = require('telescope.builtin')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings to learn the available actions


    local opts = { buffer = bufnr, remap = false }
    if client.name == "GitHub Copilot" then
        return -- Exit the function early for Copilot
    end

    if client.name == "omnisharp" then
        vim.keymap.set('n', 'gd', '<cmd>lua require("omnisharp_extended").lsp_definitions()<cr>')
        vim.keymap.set('n', 'gr', '<cmd>lua require("omnisharp_extended").lsp_references()<cr>')
        vim.keymap.set('n', 'gi', '<cmd>lua require("omnisharp_extended").lsp_implementation()<cr>')
        vim.keymap.set('n', 'gt', '<cmd>lua require("omnisharp_extended").lsp_type_definition()<cr>')
    else
        vim.keymap.set('n', 'gd', function() builtin.lsp_definitions() end, opts)
        vim.keymap.set('n', 'gr', function() builtin.lsp_references() end, opts)
        vim.keymap.set('n', 'gi', function() builtin.lsp_implementations() end, opts)
        vim.keymap.set('n', 'gt', function() builtin.lsp_type_definitions() end, opts)
    end

    vim.keymap.set('n', '<leader>fs', function() builtin.lsp_document_symbols() end, opts)
    vim.keymap.set('n', '<leader>ws', function() builtin.lsp_workspace_symbols() end, opts)
    vim.keymap.set('n', '<leader>wd', function() builtin.diagnostics() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('i', '<c-s>', function() vim.lsp.buf.signature_help({ border = "rounded" }) end, opts)
    vim.keymap.set('n', '<leader>re', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set({ 'n', 'x' }, '<a-f>', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    -- diagnostic list
end)
