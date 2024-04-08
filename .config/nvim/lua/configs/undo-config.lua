require("telescope").setup({
    extensions = {
        undo = {
            use_delta = true,
            use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
            side_by_side = false,
            diff_context_lines = vim.o.scrolloff,
            entry_format = "state #$ID, $STAT, $TIME",
            time_format = "",
            mappings = {
                i = {
                    ["y"] = require("telescope-undo.actions").yank_additions,
                    ["Y"] = require("telescope-undo.actions").yank_deletions,
                    ["u"] = require("telescope-undo.actions").restore,
                },
            },
        },
    },
})
