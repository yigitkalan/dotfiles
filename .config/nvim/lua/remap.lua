local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

local builtin = require('telescope.builtin')
local api = require('nvim-tree.api')


-- map('n', '<leader>pv', vim.cmd.Ex)
map('n', '<space>', '<nop>')

map('n', '<leader>pg', builtin.live_grep)
map('n', '<leader>pf', builtin.find_files)
map('n', '<leader>si', ':so $MYVIMRC<cr>')


-- jk to escape
map('i', 'jk', '<esc>')
map('i', 'Jk', '<esc>') map('i', 'jK', '<esc>')
map('i', 'JK', '<esc>')

map('c', 'jk', '<esc>')
map('c', 'jK', '<esc>')
map('c', 'Jk', '<esc>')
map('c', 'JK', '<esc>')

map('n', '<leader>q', api.tree.toggle)
map('n', '<leader>f', api.tree.focus)


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

-- TEST REMAPS
map('n', "<leader>tt", ":TestNearest<cr>")
map('n', "<leader>tf", ":TestFile<cr>")
map('n', "<leader>tl", ":TestLast<cr>")

map('n', "<C-h>", ":TmuxNavigateLeft<cr>")
map('n', "<C-j>", ":TmuxNavigateDown<cr>")
map('n', "<C-k>", ":TmuxNavigateUp<cr>")
map('n', "<C-l>", ":TmuxNavigateRight<cr>")



-- COC REMAPS
map('n', '<leader>re', '<Plug>(coc-rename)')
map('n', '<a-f>', ':CocCommand editor.action.formatDocument<cr>')
map('n', '<leader>o', ':CocFzfList outline<cr>')

map("n", "<leader>u", ":lua require(\"telescope\").extensions.undo.undo()<cr>")
-- map('n', '<leader>ha', ":lua require(\"harpoon.mark\").add_file()<cr>")
-- map('n', '<leader>ht', ":lua require(\"harpoon.ui\").toggle_quick_menu()<cr>")


-- vim.cmd [[
-- augroup omnisharp_commands
--   autocmd!
--
--   autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
--   autocmd FileType cs nmap <silent> <buffer> gy <Plug>(omnisharp_go_to_type_definition)
--   autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
--   autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
--   autocmd FileType cs nmap <silent> <buffer> K  <Plug>(omnisharp_documentation)
--   autocmd FileType cs nmap <silent> <buffer> <a-f> <Plug>(omnisharp_code_format)
--   autocmd FileType cs nmap <silent> <buffer> <leader>ac <Plug>(omnisharp_code_actions)
--   autocmd FileType cs nmap <silent> <buffer> <leader>o <Plug>(omnisharp_find_symbols)
--   autocmd FileType cs nmap <silent> <buffer> <leader>re <Plug>(omnisharp_rename)
--   autocmd FileType cs nmap <silent> <buffer> <a-\> <Plug>(omnisharp_signature_help)
--   autocmd FileType cs imap <silent> <buffer> <a-\> <Plug>(omnisharp_signature_help)
--   
--   " ... other omnisharp-vim mappings
-- augroup END
--
-- ]]

