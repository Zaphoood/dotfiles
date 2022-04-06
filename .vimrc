" === Plugin ===
" Set up vundle
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here
Plugin 'sbdchd/neoformat'
Plugin 'catppuccin/nvim', {'name': 'catppuccin'}
Plugin 'roxma/vim-tmux-clipboard'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Neoformat configuration
autocmd BufWritePre,TextChanged,InsertLeave *.py Neoformat


" === Keybindings ===
" F4: toggle hybrid line numbers
noremap <F4> :set nu! rnu!<CR>
inoremap <F4> :set nu! rnu!<CR>
cnoremap <F4> :set nu! rnu!<CR>

" F5: toggle whitepsace
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

" F8: autopep8 (when editing a python file)
autocmd FileType python noremap <buffer> <F8> :Neoformat<CR>

" F9: Run mypy on the current program, open quickfick window
" and jump to first error (that's what that last <CR> does)
autocmd FileType python set makeprg=mypy
autocmd FileType python noremap <F9> :make%<CR>:cw<CR><CR>

" Navigate panes easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Leader
let mapleader = ","

" Enable folding with spacebar
" set foldmethod=indent
" set foldlevel=99
" nnoremap <space> za


" Tabs as spaces
set softtabstop=4
set shiftwidth=4
set expandtab
set tabstop=4
" Use tabs for editing Makefiles
autocmd BufRead Makefile setlocal noexpandtab

" === Aesthetics ===
set number relativenumber
set ruler
set nohlsearch
set scrolloff=1
syntax on

" Whitespace characters used by `list`
set listchars=eol:$,space:.,tab:>-

" Default split behavior
set splitright
set splitbelow

" Always show file name
set laststatus=2

" Netrw settings 
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_winsize = 25
let g:netrw_altv = 2

" Force true color when using regular vim inside tmux as the
" colorscheme can appear to be grayscale with "termguicolors" option enabled.
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors

" Set colorscheme
colorscheme catppuccin
