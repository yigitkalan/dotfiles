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

g.blamer_enabled = true
g.blamer_show_in_visual_modes = false
g.blamer_show_in_insert_modes = false


-- block comment on new line after pressing enter or o
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]

vim.cmd [[
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2
]]

o.termguicolors = true
require("colorizer").setup {
    filetypes = { "*" },
    user_default_options = {
        RGB = true,          -- #RGB hex codes
        RRGGBB = true,       -- #RRGGBB hex codes
        names = false,       -- "Name" codes like Blue or blue
        RRGGBBAA = false,    -- #RRGGBBAA hex codes
        AARRGGBB = false,    -- 0xAARRGGBB hex codes
        rgb_fn = true,       -- CSS rgb() and rgba() functions
        hsl_fn = false,      -- CSS hsl() and hsla() functions
        css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false,                                -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
}

-- g.AutoPairsShortcutJump = 'a-e'
g.copilot_enabled = true
g.ale_set_highlights = 1

g.transparent_enabled = true

vim.cmd.colorscheme('github_dark_default')

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
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end


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



