local map = vim.keymap.set

-- General Keymaps
map("n", "<space>", "<nop>", { silent = true })

-- JK to escape
map("i", "jk", "<esc>", { silent = true })
map("i", "Jk", "<esc>", { silent = true })
map("i", "jK", "<esc>", { silent = true })
map("i", "JK", "<esc>", { silent = true })
map("c", "jk", "<esc>", { silent = true })
map("c", "jK", "<esc>", { silent = true })
map("c", "Jk", "<esc>", { silent = true })
map("c", "JK", "<esc>", { silent = true })

-- Move visually selected lines
map("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
map("v", "J", ":m '>+1<cr>gv=gv", { silent = true })

-- Paste without losing register
map("x", "<leader>p", [["_dP]], { silent = true })

-- Window Navigation
map("n", "<Up>", "<c-w>k", { silent = true })
map("n", "<Down>", "<c-w>j", { silent = true })
map("n", "<Right>", "<c-w>l", { silent = true })
map("n", "<Left>", "<c-w>h", { silent = true })

map("n", "<a-j>", "<c-w>j", { silent = true })
map("n", "<a-k>", "<c-w>k", { silent = true })
map("n", "<a-l>", "<c-w>l", { silent = true })
map("n", "<a-h>", "<c-w>h", { silent = true })

vim.keymap.set("n", "<leader>gp", function()
	require("telescope.builtin").find_files({
		prompt_title = "Insert Godot Resource Path",
		attach_mappings = function(_, map)
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			map("i", "<CR>", function(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				local res_path = '"res://' .. selection.value .. '"'
				vim.api.nvim_put({ res_path }, "c", true, true)
			end)
			return true
		end,
	})
end, { desc = "Godot: Insert Resource Path" })
