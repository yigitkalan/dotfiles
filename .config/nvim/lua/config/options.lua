local g = vim.g
local o = vim.opt

g.mapleader = " "

-- Options
o.hlsearch = false
o.laststatus = 2
o.number = true
o.clipboard = 'unnamedplus'
o.ignorecase = true
o.smartcase = true
o.relativenumber = true
o.showmatch = true
o.showmode = false
o.mouse = 'n'
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

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" }
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

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
  end
})

-- Auto-start the pipe listener for Godot
local function start_godot_server()
    local cwd = vim.fn.getcwd()
    -- Only run this if we're actually in a Godot project
    if vim.uv.fs_stat(cwd .. '/project.godot') then
        local pipe_path = '/tmp/godot.pipe'
        -- Clean up existing pipe on Linux to avoid "address already in use"
        if vim.uv.fs_stat(pipe_path) then os.remove(pipe_path) end
        vim.fn.serverstart(pipe_path)
    end
end

-- Execute it immediately
start_godot_server()
