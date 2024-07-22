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
        -- require 'lspconfig'.csharp_ls.setup {},
        require 'lspconfig'.gopls.setup {},
        require 'lspconfig'.tsserver.setup {},
        require 'lspconfig'.lua_ls.setup {},
        require 'lspconfig'.omnisharp.setup {
            cmd = { "dotnet", "/home/sy/Downloads/omnisharp/Omnisharp.exe" },

            settings = {
                FormattingOptions = {
                    -- Enables support for reading code style, naming convention and analyzer
                    -- settings from .editorconfig.
                    EnableEditorConfigSupport = true,
                    -- Specifies whether 'using' directives should be grouped and sorted during
                    -- document formatting.
                    OrganizeImports = nil,
                },
                MsBuild = {
                    -- If true, MSBuild project system will only load projects for files that
                    -- were opened in the editor. This setting is useful for big C# codebases
                    -- and allows for faster initialization of code navigation features only
                    -- for projects that are relevant to code that is being edited. With this
                    -- setting enabled OmniSharp may load fewer projects and may thus display
                    -- incomplete reference lists for symbols.
                    LoadProjectsOnDemand = nil,
                },
                RoslynExtensionsOptions = {
                    -- Enables support for roslyn analyzers, code fixes and rulesets.
                    EnableAnalyzersSupport = nil,
                    -- Enables support for showing unimported types and unimported extension
                    -- methods in completion lists. When committed, the appropriate using
                    -- directive will be added at the top of the current file. This option can
                    -- have a negative impact on initial completion responsiveness,
                    -- particularly for the first few completion sessions after opening a
                    -- solution.
                    EnableImportCompletion = nil,
                    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                    -- true
                    AnalyzeOpenDocumentsOnly = nil,
                },
                Sdk = {
                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    IncludePrereleases = true,
                },
            },
        }
    },
})
