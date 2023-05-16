local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

local builtin = require('telescope.builtin')
local api = require('nvim-tree.api')


-- map('n', '<leader>pv', vim.cmd.Ex)
map('n', '<space>', '<nop>')

map('n', '<leader>pf', builtin.find_files)
map('n', '<leader>pg', builtin.live_grep)
map('n', '<leader>si', ':so $MYVIMRC<cr>')

-- keep the cursor in the middle while searching
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- jk to escape
map('i', 'jk','<esc>')
map('i', 'Jk','<esc>')
map('i', 'jK','<esc>')
map('i', 'JK','<esc>')

map('c', 'jk','<esc>')
map('c', 'jK','<esc>')
map('c', 'Jk','<esc>')
map('c', 'JK','<esc>')

map('n', '<leader>q',api.tree.toggle)
map('n', '<leader>f',api.tree.focus)


-- move visually selected lines
map('v', 'K', ":m '<-2<cr>gv=gv")
map('v', 'J', ":m '>+1<cr>gv=gv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- disable arrows
map('n','<up>', '<c-w>k')
map('n','<down>', '<c-w>j')
map('n','<right>', '<c-w>l')
map('n','<left>', '<c-w>h')

map('n','<a-k>', '<c-w>k')
map('n','<a-j>', '<c-w>j')
map('n','<a-l>', '<c-w>l')
map('n','<a-h>', '<c-w>h')

map('n','<leader>u', vim.cmd.UndotreeToggle)


