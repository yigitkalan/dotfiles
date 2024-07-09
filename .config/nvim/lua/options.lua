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


vim.cmd([[
let g:tmux_navigator_no_mappings = 1
]])



-- coc fzf settings
vim.cmd([[
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.7 } }
]])

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
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false, -- Enable tailwind colors
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

vim.cmd.colorscheme('tokyonight')

-- to continue file where you left of
vim.cmd [[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
  endif
  ]]
