" Leader
let g:mapleader = ","
let maplocalleader = ","

" VimTeX
" Use Zathura as the PDF viewer
let g:vimtex_view_method = 'zathura'

" === Keybindings ===
" F4: toggle hybrid line numbers
noremap <F4> :set rnu!<CR>
inoremap <F4> :set rnu!<CR>
cnoremap <F4> :set rnu!<CR>

" F5: toggle whitepsace
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

set softtabstop=4
set shiftwidth=4
set expandtab
set tabstop=4
autocmd Filetype c,cpp,html,css,javascript,typescript,markdown set softtabstop=2
autocmd Filetype c,cpp,html,css,javascript,typescript,markdown set shiftwidth=2
autocmd Filetype c,cpp,html,css,javascript,typescript,markdown set tabstop=2

" Use tabs for Go and Makefiles
autocmd Filetype go setlocal noexpandtab
autocmd BufRead Makefile setlocal noexpandtab

" Emacs-like navigation in insert mode
inoremap <C-A> <Home>
inoremap <C-E> <End>

" LaTeX Bindings
" Create new `align*` block
autocmd Filetype tex nnoremap <leader>bl o\begin{align*}<BS>\end{align*}kA	
" Create new `enumerate` block
autocmd Filetype tex nnoremap <leader>be o\begin{enumerate}<BS>\end{enumerate}kA
" Create new `proof` block
autocmd Filetype tex nnoremap <leader>bp o\begin{proof}<BS>\end{proof}kA
autocmd Filetype tex imap <C-]> \{  \}hhi

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

