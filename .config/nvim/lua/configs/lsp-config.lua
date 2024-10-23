local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings to learn the available actions


    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local opts = { buffer = event.buf }
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', 'gd', function() builtin.lsp_definitions() end, opts)
            vim.keymap.set('n', 'gr', function() builtin.lsp_references() end, opts)
            vim.keymap.set('n', 'gi', function() builtin.lsp_implementations() end, opts)
            vim.keymap.set('n', 'gt', function() builtin.lsp_type_definitions() end, opts)
            vim.keymap.set('n', '<leader>fs', function() builtin.lsp_document_symbols() end, opts)
            vim.keymap.set('n', '<leader>ws', function() builtin.lsp_workspace_symbols() end, opts)
            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
            vim.keymap.set('i', '<c-s>', function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set('n', '<leader>re', function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set({ 'n', 'x' }, '<a-f>', function() vim.lsp.buf.format({ async = true }) end, opts)
            vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

        end

    })
    local opts = { buffer = bufnr, remap = false }

    -- Check if omnisharp is currently running
    local has_omnisharp = false
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, c in ipairs(clients) do
        if c.name == "omnisharp" then
            has_omnisharp = true
            break
        end
    end
    -- Custom keybindings for Omnisharp and override
    if has_omnisharp then
        vim.keymap.set('n', 'gd', '<cmd>lua require("omnisharp_extended").lsp_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua require("omnisharp_extended").lsp_references()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua require("omnisharp_extended").lsp_implementation()<cr>', opts)
        vim.keymap.set('n', 'gt', '<cmd>lua require("omnisharp_extended").lsp_type_definition()<cr>', opts)
    end
end)
