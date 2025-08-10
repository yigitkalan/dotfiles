local g = vim.g
local o = vim.opt

g.mapleader = " "
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
o.undodir = '/home/sy/.vim/undo'
o.guicursor = "n-i:block-blinkwait1000-blinkon500-blinkoff500,i-ci-ve:ver25,r-cr:hor20,o:hor50";


-- block comment on new line after pressing enter or o
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]

vim.cmd [[
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2
]]

o.termguicolors = true

-- g.AutoPairsShortcutJump = 'a-e'
g.copilot_enabled = false
g.ale_set_highlights = 1

g.transparent_enabled = true

vim.cmd.colorscheme('tokyonight-night')

-- remove ugly background of the floating window borders
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

-- to continue file where you left of
vim.cmd [[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
  endif
  ]]

-- -- comment this if you rather prefer visual text for diagnostics
vim.diagnostic.config({
    -- use virtual_lines with toggle remap
    virtual_lines = false,

    virtual_text = false, -- Disable inline diagnostics
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

-- for diagnostics icons
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" }
}
-- Configure diagnostic signs using vim.diagnostic.config
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs[1].text,
            [vim.diagnostic.severity.WARN] = signs[2].text,
            [vim.diagnostic.severity.INFO] = signs[3].text,
            [vim.diagnostic.severity.HINT] = signs[4].text,
        },
        -- Optionally, set text highlight groups
        texthl = {
            [vim.diagnostic.severity.ERROR] = signs[1].name,
            [vim.diagnostic.severity.WARN] = signs[2].name,
            [vim.diagnostic.severity.INFO] = signs[3].name,
            [vim.diagnostic.severity.HINT] = signs[4].name,
        },
        -- Optionally, set number highlight groups (if needed, can be empty as in your original code)
        numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})


-- open diagnostics only if there is no floating window open
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

-- Show diagnostics in a floating window when hovering
vim.o.updatetime = 250
