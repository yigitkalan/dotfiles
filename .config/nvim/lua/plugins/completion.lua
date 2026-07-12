return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
            },
            appearance = { nerd_font_variant = "mono" },
            completion = {
                list = { selection = { preselect = true } },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    window = { border = "single" },
                },
                menu = {
                    border = "single",
                    draw = {
                        columns = {
                            { "kind_icon", gap = 1 },
                            { "label", "label_description", gap = 1 },
                        },
                    },
                },
                trigger = { show_on_keyword = true },
            },
            sources = { default = { "lsp", "path", "snippets", "buffer" } },
        },
    },
}
