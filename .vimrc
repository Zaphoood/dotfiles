call plug#begin()

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Syntax highlighting using the CXX LSP
" Plug 'jackguo380/vim-lsp-cxx-highlight'
" Code formatter
Plug 'sbdchd/neoformat'
" Catppuccin colorscheme
Plug 'catppuccin/nvim', {'name': 'catppuccin'}
" Seamless copy-pasting between tmux splits
Plug 'roxma/vim-tmux-clipboard'
" fugitive (for git)
Plug 'tpope/vim-fugitive'
" VimTeX for editing LaTeX files
Plug 'lervag/vimtex'

call plug#end()

" Leader
let g:mapleader = ","
let maplocalleader = ","

" Neoformat configuration
autocmd BufWritePre,TextChanged,InsertLeave *.py Neoformat

" VimTeX
" Use Zathura as the PDF viewer
let g:vimtex_view_method = 'zathura'

" === CoC ===
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" === Keybindings ===
" F4: toggle hybrid line numbers
noremap <F4> :set rnu!<CR>
inoremap <F4> :set rnu!<CR>
cnoremap <F4> :set rnu!<CR>

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

" Enable folding with spacebar
nnoremap <space> za
autocmd Filetype python set foldmethod=indent
autocmd Filetype c,cpp set foldmethod=syntax
set foldlevel=99

" Tabs as spaces
set softtabstop=4
set shiftwidth=4
set expandtab
set tabstop=4

autocmd Filetype c,cpp,html,css set softtabstop=2
autocmd Filetype c,cpp,html,css set shiftwidth=2
autocmd Filetype c,cpp,html,css set tabstop=2

" Use tabs for editing Makefiles
autocmd BufRead Makefile setlocal noexpandtab

" Some Emacs-like navigation in insert mode
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

" CoC colors
highlight! CocErrorSign guifg=tomato

