" All Plugins managed by Plugin Manager {{{
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'dkprice/vim-easygrep'
Plug 'airblade/vim-rooter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'justinmk/vim-sneak'
Plug 'ckarnell/Antonys-macro-repeater'
Plug 'wincent/ferret'
Plug 'dhruvasagar/vim-table-mode'
Plug 'davidhalter/jedi-vim'
" Python Formatting Plugins
Plug 'hynek/vim-python-pep8-indent'
Plug 'tell-k/vim-autopep8'
Plug 'bronson/vim-trailing-whitespace'
Plug 'w0rp/ale'
" Language-specific highlighting
Plug 'hdima/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'derekwyatt/vim-scala'
Plug 'jparise/vim-graphql'
Plug 'ekalinin/Dockerfile.vim'
Plug 'magicalbanana/sql-syntax-vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'vim-scripts/groovyindent-unix'
Plug 'chr4/nginx.vim'
Plug 'cespare/vim-toml'
" Future Plugins to install:
  " Airline
  " TagBar
  " AutoComplete
  " Quickfix, use shortcuts
  " WinResizer
  " OmniCompletion
call plug#end()
" }}}

" Color Scheme Settings {{{
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
"}}}

" General Settings {{{
syntax on
let mapleader = ","
let maplocalleader = "\\"
let python_highlight_all=1
set number
set tabstop=2
set autoindent
set colorcolumn=80
set hidden " Enable buffer deletion
highlight ColorColumn ctermbg=darkgrey
set nobackup " Avoid swap files
set noswapfile " Avoid swap files
set wrap
set spelllang=en_us
set nocompatible " Turn off complete vi compatibility
" }}}

" Mappings {{{
noremap ii o<esc>
noremap <c-c> ^i# <esc>
" noremap <C-S-C> "+yy
" noremap <C-S-V> "+p
inoremap <c-z> <esc>ui

" Mapping for finding by entire Word
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

" }}}

" fix misspellings and abbreviations of commands {{{

" fix misspelling of ls (which lists Buffers)
cabbrev LS ls
cabbrev lS ls
cabbrev Ls ls

" fix misspelling of vs and sp
cabbrev SP sp
cabbrev sP sp
cabbrev Sp sp
cabbrev VS vs
cabbrev vS vs
cabbrev Vs vs


" move tab to number
cabbrev t tabn

" close help menu
cabbrev hc helpclose

" echo current file path
cabbrev pwd echo expand('%:p')

" abbreviate creating tab, vertical, and horizontal buffer splits
cabbrev bt tab sb
cabbrev bv vert sb
cabbrev bs sbuffer


" }}}
"
" Folding settings: {{{
augroup fold_settings
  autocmd!
  autocmd FileType vim,tmux setlocal foldmethod=marker
  autocmd FileType vim,tmux setlocal foldlevelstart=0
  autocmd BufNewFile,BufRead .zprofile,.bashrc,.zshrc setlocal foldmethod=marker
  autocmd BufNewFile,BufRead .zprofile,.bashrc,.zshrc setlocal foldlevelstart=0
augroup END
" nnoremap z<space> zA
"}}}

" Newline on commas (for function parameters) {{{
" usable with repeat operator '.'
nnoremap <silent> <Plug>NewLineComma f,wi<CR><Esc>
      \:call repeat#set("\<Plug>NewLineComma")<CR>
nmap <leader><CR> <Plug>NewLineComma
"}}}

" Nerd Tree {{{
let g:NERDTreeMapOpenInTab = '<C-t>'
let g:NERDTreeMapOpenSplit = '<C-s>'
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeCaseSensitiveSort = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 31
let g:NERDTreeAutoDeleteBuffer = 2
let g:NERDTreeIgnore=['venv$[[dir]]', '__pycache__$[[dir]]', 'node_modules$[[dir]]']
nnoremap <silent> <space>j :NERDTreeToggle %<CR>
" }}}

" Ale Linter {{{

let g:ale_lint_on_text_changed = 0 " turn off automatic checks
let g:ale_lint_on_save = 1 " check only on file save

" }}}
"
" Jedi {{{

let g:jedi#auto_initialization = 0

" }}}


" Move from one window to another {{{
" BuffersAndWindows:
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
"
" Scroll screen up and down
" nnoremap <silent> K <c-e>
" nnoremap <silent> J <c-y>
"
" Switch buffers
nnoremap gn :bn<CR>
nnoremap gd :BD<CR>
nnoremap gp :bp<CR>
" }}}

" EasyGrep - use git grep {{{
set grepprg=git\ grep\ -n\ $*
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match
" }}}

" VisualSearch - use * and # in visual mode {{{
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'
" }}}

"  Plugin: Rainbow Parentheses {{{

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
augroup rainbow_settings
  " Section to turn on rainbow parentheses
  autocmd!
  autocmd BufEnter,BufRead * :RainbowParentheses
  autocmd BufEnter,BufRead *.html,*.css,*.jsx,*.js :RainbowParentheses!
augroup END

"  }}}

" Vimux prompt for a command to run {{{
map <Leader>vc :VimuxPromptCommand<CR>
map <Leader>vp :VimuxRunLastCommand<CR>
" }}}

" Ctrl p {{{
let g:ctrlp_working_path_mode = 'rw' " start from cwd
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0
" }}}

" vim-fugitive {{{
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>g. :Git add .<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
" }}}

" vim-python-pep8-index: Automatic indent matching Python Pep 8 Guidelines {{{
augroup indentation_le
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype yaml setlocal indentkeys-=<:>
  autocmd Filetype dot :setlocal autoindent cindent
  autocmd Filetype make,tsv,votl
        \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
augroup END
" }}}

" vim-trailing-whitespace {{{
augroup fix_whitespace_save
  let blacklist = ['markdown']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | execute ':FixWhitespace'
augroup END
" }}}

" Javascript settings {{{
let g:javascript_plugin_flow = 1
" }}}
