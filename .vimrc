call plug#begin()
Plug 'preservim/nerdtree'

Plug 'honza/vim-snippets'

Plug 'ryanoasis/vim-devicons'

Plug 'itchyny/lightline.vim'

Plug 'frazrepo/vim-rainbow'

Plug 'mg979/vim-visual-multi'

Plug 'jiangmiao/auto-pairs'

"will need node js to work
Plug 'OmniSharp/omnisharp-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'



call plug#end()

set tabstop =4
set shiftwidth =4
set expandtab
set autoindent


set nohlsearch 
" make leader key space
nnoremap <SPACE> <Nop>
let mapleader = " "

" Jump outside of pairs"({
if !exists('g:AutoPairsShortcutJump')
    let g:AutoPairsShortcutJump = '<C-l>'
endif



"grey color for coc highlight
highlight CocFloating ctermfg=8


"can use CTRL+W to switch between currently open windows
"like internal terminal and vim buffer

"also line in :CocConfig is for selecting the first suggestion


"for opening internal terminal in current vim directory
set autochdir



" let g:coc_global_extensions=[ 
"             \'coc-omnisharp',
"             \ 'coc-pyright',
"             \ 'coc-java' ]


" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()


let g:OmniSharp_highlighting = 0


"for rainbow parantheses
let g:rainbow_active = 1


"for lightline and removing old bar
set laststatus=2
set noshowmode

let g:lightline = {
            \ 'colorscheme': 'deus',
            \ }



set clipboard=unnamedplus

set relativenumber


"deactive arrow keys
inoremap OC <NOP>
inoremap OB <NOP>
inoremap OD <NOP>
inoremap OA <NOP>

"when alt-tab quit insert mode automatically
inoremap [O <ESC>

" Press jk to return to normal mode when in insert mode
" consider all combinations to avoid mistake
inoremap jK <ESC>
inoremap Jk <ESC>
inoremap JK <ESC>
inoremap jk <ESC>
inoremap <ESC> <NOP>


"Slows down
" Press jk to return to normal mode when in visual mode
" vnoremap jK <ESC>
" vnoremap Jk <ESC>
" vnoremap JK <ESC>
" vnoremap jk <ESC>
" vnoremap <ESC> <NOP>

" Press jk when in Command mode, to go back to normal mode
cnoremap jK <ESC>
cnoremap Jk <ESC>
cnoremap JK <ESC>
cnoremap jk <ESC>

" nerdtree short cut
nnoremap <C-t> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1

" 256 color support
set t_Co=256

" pasting w/o extra space
set pastetoggle=<C-p>

" show matching parantheses
set showmatch

"to get the hjkl habit
noremap! <Up> <NOP>
noremap! <Down> <NOP>
noremap! <Left> <NOP>
noremap! <Right> <NOP>
noremap <Up> <nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>



"highlights syntax
syntax on

"show line numbers
set number

"ignore case in search
set ignorecase

"show results as you type
set incsearch

