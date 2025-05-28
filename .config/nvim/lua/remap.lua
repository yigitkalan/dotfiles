local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

local builtin = require('telescope.builtin')
local api = require('nvim-tree.api')


-- map('n', '<leader>pv', vim.cmd.Ex)
map('n', '<space>', '<nop>')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'gra')

map('n', '<leader>pg', builtin.live_grep)
map('n', '<leader>pf', builtin.find_files)


-- jk to escape
map('i', 'jk', '<esc>')
map('i', 'Jk', '<esc>')
map('i', 'jK', '<esc>')
map('i', 'JK', '<esc>')

map('c', 'jk', '<esc>')
map('c', 'jK', '<esc>')
map('c', 'Jk', '<esc>')
map('c', 'JK', '<esc>')

map('n', '<leader>q', api.tree.toggle)


-- move visually selected lines
map('v', 'K', ":m '<-2<cr>gv=gv")
map('v', 'J', ":m '>+1<cr>gv=gv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- make arrows for split navigation
map('n', '<Up>', '<c-w>k')
map('n', '<Down>', '<c-w>j')
map('n', '<Right>', '<c-w>l')
map('n', '<Left>', '<c-w>h')

map('n', '<a-j>', '<c-w>j')
map('n', '<a-k>', '<c-w>k')
map('n', '<a-l>', '<c-w>l')
map('n', '<a-h>', '<c-w>h')

map('n', "<C-h>", ":TmuxNavigateLeft<cr>")
map('n', "<C-j>", ":TmuxNavigateDown<cr>")
map('n', "<C-k>", ":TmuxNavigateUp<cr>")
map('n', "<C-l>", ":TmuxNavigateRight<cr>")


-- GITSIGNS
map("n", "]c", ":Gitsigns next_hunk<cr>")
map("n", "[c", ":Gitsigns prev_hunk<cr>")
map("n", "<leader>hp", ":Gitsigns preview_hunk<cr>")
map("n", "<leader>hs", ":Gitsigns stage_hunk<cr>")
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<cr>")
map("n", "<leader>hr", ":Gitsigns reset_hunk<cr>")
map("n", "<leader>bt", ":Gitsigns toggle_current_line_blame<cr>")



map('n', '<leader>u', vim.cmd.UndotreeToggle)

-- HARPOON
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
map('n', "<leader>ht", function() ui.toggle_quick_menu() end)
map('n', "<leader>a", function() mark.add_file() end)
map('n', "<a-]>", function() ui.nav_next() end)
map('n', "<a-[>", function() ui.nav_prev() end)
local harpoon_ui = require("harpoon.ui")
for i = 1, 9 do
    map('n', "<a-" .. i .. ">", function()
        harpoon_ui.nav_file(i)
    end)
end
