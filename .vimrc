" All My Plugins managed by my Plugin Manager
call plug#begin('~/.vim/plugged')
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'hynek/vim-python-pep8-indent'
Plug 'dkprice/vim-easygrep'
Plug 'airblade/vim-rooter'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" General Settings
syntax on
set number
set tabstop=2
set autoindent
let python_highlight_all=1
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
let &colorcolumn=join(range(81, 1000), ",") " highlight line 81-on
let mapleader = ","

" Mappings
noremap :kb :NERDTreeToggle<CR>
noremap ii o<esc>
noremap <c-c> ^i# <esc>
" noremap <C-S-C> "+yy
" noremap <C-S-V> "+p
inoremap ` <esc>
inoremap <c-z> <esc>ui

" Color Scheme Settings
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256

" Nerd Tree
let g:NERDTreeQuitOnOpen = 1

" EasyGrep - use git grep
set grepprg=git\ grep\ -n\ $*
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match

" Ctrl p
let g:ctrlp_working_path_mode = 'rw' " start from cwd
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0


augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
    autocmd BufEnter * match OverLength /\%75v.*/
augroup END


" vim-python-pep8-index: Automatic indent matching Python Pep 8 Guidelines
augroup indentation_le
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype yaml setlocal indentkeys-=<:>
  autocmd Filetype dot :setlocal autoindent cindent
augroup END

" vim-trailing-whitespace
augroup fix_whitespace_save
  let blacklist = ['markdown']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | execute ':FixWhitespace'
augroup END

