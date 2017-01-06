" All My Plugins managed by my Plugin Manager
call plug#begin('~/.vim/plugged')
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/nerdtree'
call plug#end()

let python_highlight_all=1
let g:NERDTreeQuitOnOpen = 1

syntax on
set number
set tabstop=2
set autoindent
set t_Co=256

noremap :kb :NERDTreeToggle<CR>
noremap ii o<esc>
noremap <c-c> ^i# <esc>

inoremap ` <esc>
inoremap <c-z> <esc>ui


augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
    autocmd BufEnter * match OverLength /\%75v.*/
augroup END

highlight ColorColumn ctermbg=darkgrey guibg=darkgrey


augroup indentation_le
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype yaml setlocal indentkeys-=<:>
augroup END


augroup fix_whitespace_save
  let blacklist = ['markdown']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | execute ':FixWhitespace'
augroup END

