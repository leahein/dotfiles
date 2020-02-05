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
Plug 'w0rp/ale'

" Python Formatting Plugins
Plug 'hynek/vim-python-pep8-indent'
Plug 'tell-k/vim-autopep8'
Plug 'bronson/vim-trailing-whitespace'

" JS Formatting Plugins
Plug 'tpope/vim-ragtag'


" Markdown Plugins
Plug 'tpope/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
"
" Language-specific highlighting
Plug 'hdima/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'evanleck/vim-svelte'
Plug 'derekwyatt/vim-scala'
Plug 'jparise/vim-graphql'
Plug 'ekalinin/Dockerfile.vim'
Plug 'magicalbanana/sql-syntax-vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'vim-scripts/groovyindent-unix'
Plug 'chr4/nginx.vim'
Plug 'cespare/vim-toml'

" Language Server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Future Plugins to install:
  " Airline
  " TagBar
  " AutoComplete
  " Quickfix, use shortcuts
  " WinResizer
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
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
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

" Clear highlighting after find with esc
nnoremap <silent> <esc> :noh<return><esc>
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

" abbreviate creating tab, vertical, and horizontal buffer splits
cabbrev bt tab sb
cabbrev bv vert sb
cabbrev bs sbuffer

" jsdoc abbreviation
iabbrev jsd /** */

" }}}

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

" Language Client {{{

let g:LanguageClient_serverCommands = {
      \ 'typescript': ['npx', 'typescript-language-server', '--stdio'],
      \ 'typescript.tsx': ['npx', 'typescript-language-server', '--stdio'],
      \ }
"       \ 'python': ['jedi-language-server'],
let g:LanguageClient_autoStart = 1
let g:LanguageClient_hoverPreview = 'Auto'
let g:LanguageClient_diagnosticsEnable = 0

function! ConfigureLanguageClient()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <leader>d :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <leader>sd :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> <leader>sr :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer> <leader>su :call LanguageClient#textDocument_references()<CR>
    setlocal omnifunc=LanguageClient#complete
  endif
endfunction

augroup language_servers
  autocmd FileType * call ConfigureLanguageClient()
augroup END
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

" Jedi {{{

let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#auto_vim_configuration = 0

augroup jedi_config_le
  autocmd FileType python setlocal completeopt-=preview "No docstring window in completion
augroup END
" }}}

" RagTag {{{

" Load mappings on every filetype
let g:ragtag_global_maps = 1

" Additional file type
augroup ragtag_config
  autocmd!
  autocmd FileType javascript call RagtagInit()
  autocmd FileType svelte call RagtagInit()
augroup END

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

" Typescript config {{{
augroup tsx_recognition
 autocmd!
 autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END
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


" Writing formatting {{{
augroup fix_whitespace_save
  autocmd!
  autocmd FileType markdown,rst,text,gitcommit
    \ setlocal wrap linebreak nolist
augroup END

nnoremap <expr> k
  \ v:count == 0 ? 'gk' : 'k'
vnoremap <expr> k
  \ v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j
  \ v:count == 0 ? 'gj' : 'j'
vnoremap <expr> j
  \ v:count == 0 ? 'gj' : 'j'

" }}}

" Javascript settings {{{
let g:javascript_plugin_flow = 1
" }}}
