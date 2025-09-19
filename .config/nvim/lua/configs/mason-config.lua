-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({
    registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
        },
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
        ["omnisharp"] = function()
            require("lspconfig").omnisharp.setup({
                handlers = {
                    ["textDocument/definition"] = require("omnisharp_extended").telescope_lsp_definition({
                        jump_type =
                        "vsplit"
                    }),
                    ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
                    ["textDocument/references"] = require("omnisharp_extended").references_handler,
                    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
                },
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = nil,
                    },
                    MsBuild = {
                        LoadProjectsOnDemand = true,
                    },
                },
            })
        end,
    },
})
