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
o.termguicolors = true
o.fileformats = "unix,dos"

o.wrap = true
o.linebreak = true -- Don't break words in the middle
o.breakindent = true -- Keep indentation on wrapped line
o.textwidth = 120 -- Set maximum width for text
o.colorcolumn = "120" -- Show a vertical line at 120 characters
o.statusline = " %f %m%=%l:%c  %{&filetype} "

-- Disable netrw (we use oil.nvim)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Fold options
o.foldmethod = "expr"
-- o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldexpr = "indent"
o.foldcolumn = "1" -- Show the fold column
o.foldlevel = 99 -- Keep all folds open by default when opening a file
o.foldlevelstart = 99
o.foldenable = true
-- za	Toggle the fold at the cursor (Open if closed, close if open).
-- zc	Close the fold at the cursor.
-- zo	Open the fold at the cursor.
-- zM	Close all folds in the file (great for a bird's-eye view).
-- zR	Open all folds in the file (back to normal).

o.completeopt = {"menu", "menuone", "noselect"}

-- vim.cmd.colorscheme("tokyonight-night")
local function set_transparent()
    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
    vim.api.nvim_set_hl(0, "FloatBorder", {bg = "none"})
    vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
    vim.api.nvim_set_hl(0, "StatusLine", {bg = "none"})
    vim.api.nvim_set_hl(0, "StatusLineNC", {bg = "none"})
    vim.api.nvim_set_hl(0, "EndOfBuffer", {bg = "none"})
end

set_transparent() -- run on startup

vim.api.nvim_create_autocmd("ColorScheme",
                            {pattern = "*", callback = set_transparent})

-- Disable some format options
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function() vim.opt_local.formatoptions:remove({"c", "r", "o"}) end
})

-- Filetype specific indentation
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"html", "typescript", "typescriptreact", "markdown"},
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end
})

-- Remove ugly background of the floating window borders
vim.api.nvim_set_hl(0, "FloatBorder", {bg = "NONE"})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})

-- PowerShell configuration
-- if vim.loop.os_uname().sysname == "Windows_NT" then
--     o.shell = "C:\\msys64\\usr\\bin\\zsh.exe"
--     o.shellquote = ""
--     o.shellcmdflag = "-ic"
--     o.shellxquote = ""
--     o.shellpipe = "2>&1 | tee %s; exit ${PIPESTATUS[0]}"
--     o.shellredir = ">%s 2>&1"
-- end
if vim.loop.os_uname().sysname == "Windows_NT" then
    local shell = (vim.fn.executable("pwsh.exe") == 1) and "pwsh.exe" or
                      "powershell.exe"
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
        prefix = ""
    }
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = ""
        }
    }
})

-- Open diagnostics on hover
vim.api.nvim_create_autocmd({"CursorHold"}, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then return end
        end
        vim.diagnostic.open_float({
            focusable = false,
            scope = "cursor",
            close_events = {
                "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre",
                "WinLeave"
            }
        })
    end
})

-- local function start_godot_server()
-- 	local addr
-- 	if vim.fn.has("win32") == 1 then
-- 		addr = "127.0.0.1:55432" -- TCP on Windows, pipes are unreliable
-- 	else
-- 		local pipe_path = "/tmp/godot.pipe"
-- 		if vim.uv.fs_stat(pipe_path) then
-- 			os.remove(pipe_path)
-- 		end
-- 		addr = pipe_path
-- 	end

-- 	local ok, err = pcall(vim.fn.serverstart, addr)
-- 	if ok then
-- 		vim.notify("Godot server ready: " .. addr, vim.log.levels.INFO)
-- 	else
-- 		if not string.find(tostring(err), "already in use") then
-- 			vim.notify("Server failed: " .. tostring(err), vim.log.levels.ERROR)
-- 		end
-- 	end
-- end

-- -- Execute it immediately
-- start_godot_server()
