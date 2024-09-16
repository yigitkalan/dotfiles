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
        }
    }
}
