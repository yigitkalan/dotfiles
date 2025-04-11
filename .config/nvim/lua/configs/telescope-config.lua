require "telescope".setup {
    defaults = {
        file_ignore_patterns = {
            "%.asset",
            "%.unity",
            "%.meta",
            "%.bin",
            -- Add more patterns here as needed
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = true
        },
        lsp_document_symbols = {
            previewer = false,
            layout_config = {
                width = 0.5,  -- Adjust the width as needed
                height = 0.7, -- Adjust the height as needed
            }
        },
        lsp_workspace_symbols = {
            previewer = false,
            layout_config = {
                width = 0.5,  -- Adjust the width as needed
                height = 0.7, -- Adjust the height as needed
            }
        },
        find_files = {
            previewer = false,
            layout_config = {
                width = 0.5,  -- Adjust the width as needed
                height = 0.7, -- Adjust the height as needed
            } },
        live_grep = {
            previewer = true,
            layout_config = {
                width = 0.7,                      -- Total width of the picker
                preview_cutoff = 1,               -- Always show the previewer
                preview_width = function(_, cols, _)
                    return math.floor(cols * 0.6) -- Width of the preview section (60% of total width)
                end,
            }
        },
        lsp_references = {
            previewer = true,
            layout_config = {
                width = 0.7,                      -- Total width of the picker
                preview_cutoff = 1,               -- Always show the previewer
                preview_width = function(_, cols, _)
                    return math.floor(cols * 0.6) -- Width of the preview section (60% of total width)
                end,
            }
        }

    },
}
