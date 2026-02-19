local g = vim.g
local o = vim.opt

g.mapleader = " "

-- Options
o.hlsearch = false
o.laststatus = 2
o.number = true
o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
o.relativenumber = true
o.showmatch = true
o.showmode = false
o.mouse = "n"
o.incsearch = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.updatetime = 50
o.swapfile = false
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undo" -- Better to use stdpath
o.guicursor = "n-i:block-blinkwait1000-blinkon500-blinkoff500,i-ci-ve:ver25,r-cr:hor20,o:hor50"
o.termguicolors = true

o.wrap = true
o.linebreak = true -- Don't break words in the middle
o.breakindent = true -- Keep indentation on wrapped line
o.textwidth = 120 -- Set maximum width for text
o.colorcolumn = "120" -- Show a vertical line at 120 characters

-- Fold options
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldcolumn = "1" -- Show the fold column
o.foldlevel = 99 -- Keep all folds open by default when opening a file
o.foldlevelstart = 99
o.foldenable = true
-- za	Toggle the fold at the cursor (Open if closed, close if open).
-- zc	Close the fold at the cursor.
-- zo	Open the fold at the cursor.
-- zM	Close all folds in the file (great for a bird's-eye view).
-- zR	Open all folds in the file (back to normal).

o.completeopt = { "menu", "menuone", "noselect" }

vim.cmd.colorscheme("rose-pine-main")

-- Disable some format options
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Filetype specific indentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "typescript", "typescriptreact" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})

-- Remove ugly background of the floating window borders
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- PowerShell configuration
if vim.loop.os_uname().sysname == "Windows_NT" then
	local shell = (vim.fn.executable("pwsh.exe") == 1) and "pwsh.exe" or "powershell.exe"
	o.shell = shell
	o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	o.shellquote = ""
	o.shellxquote = ""
	o.shellpipe = "| Out-File -Encoding UTF8 %s; exit $LastExitCode"
	o.shellredir = "| Out-File -Encoding UTF8 %s; exit $LastExitCode"
end

-- Diagnostics configuration
vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		max_width = 80,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

-- Open diagnostics on hover
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	callback = function()
		for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(winid).zindex then
				return
			end
		end
		vim.diagnostic.open_float({
			focusable = false,
			scope = "line",
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"WinLeave",
			},
		})
	end,
})

local function start_godot_server()
	local uv = vim.uv or vim.loop
	local cwd = uv.cwd()

	-- Check if we're in a Godot project
	if uv.fs_stat(cwd .. "/project.godot") then
		local pipe_path

		if vim.fn.has("win32") == 1 then
			-- Windows Named Pipe
			pipe_path = [[\\.\pipe\godot-nvim]]
		else
			-- Linux/macOS Unix Domain Socket
			pipe_path = "/tmp/godot.pipe"

			-- Clean up existing socket on Unix to avoid "address already in use"
			if uv.fs_stat(pipe_path) then
				os.remove(pipe_path)
			end
		end

		-- Start the server
		local ok, err = pcall(vim.fn.serverstart, pipe_path)
		if not ok then
			vim.notify("Failed to start Godot server: " .. tostring(err), vim.log.levels.ERROR)
		end
	end
end

-- Execute it immediately
start_godot_server()
