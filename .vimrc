" All Plugins managed by Plugin Manager {{{
call plug#begin('~/.vim/plugged')

Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'dkprice/vim-easygrep'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'justinmk/vim-sneak'
Plug 'ckarnell/Antonys-macro-repeater'
Plug 'wincent/ferret'
Plug 'dhruvasagar/vim-table-mode'
Plug 'w0rp/ale'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/hedengran/fga.nvim'
Plug 'tanvirtin/monokai.nvim'

" AI
Plug 'greggh/claude-code.nvim'
Plug 'nvim-lua/plenary.nvim'

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
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'sotte/presenting.nvim'

" Language-specific highlighting
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
Plug 'elixir-editors/vim-elixir'
Plug 'hashivim/vim-terraform'
Plug 'pantharshit00/vim-prisma'
Plug 'jxnblk/vim-mdx-js'

" CoC intellisense, the future
Plug 'neoclide/coc.nvim', {'branch': 'release'}
for coc_plugin in [
      \ 'pappasam/coc-jedi',
      \ 'neoclide/coc-html',
      \ 'neoclide/coc-css',
      \ 'neoclide/coc-json',
      \ 'neoclide/coc-tsserver',
      \ 'neoclide/coc-yaml',
      \ 'iamcco/coc-vimlsp',
      \ 'josa42/coc-docker',
      \ 'neoclide/coc-pairs',
      \ 'pantharshit00/coc-prisma',
      \ 'neoclide/coc-highlight',
      \ ]
  Plug coc_plugin, { 'do': 'yarn install --frozen-lockfile' }
endfor

call plug#end()
"}}}

" Tree Sitter (highlighting) {{{

function! HandleVimEnter()
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'python',
    'javascript',
    'typescript',
    'tsx',
    'html',
    'css',
    'json',
    'yaml',
    'toml',
    'bash',
  },
  highlight = {
    enable = true, 
    disable = {},
  },
}
EOF
endfunction
augroup vimenter
  autocmd! VimEnter * call HandleVimEnter()
augroup END
" }}}

" Color Scheme Settings {{{

colorscheme monokai

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
set mouse=a " Enable mouse support
set title " Set title of terminal to filename
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

" jsdoc multiline abbreviation
iabbrev jsdm 
  \<CR>/**
  \<CR>*
  \<CR>*/

" abbreviate markdown image
iabbrev mdi ![Text](path/to/image)

" abbreviate python Dict[str, Any]
iabbrev dsa Dict[str, Any]
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

" CoC Intellisense {{{
nmap <silent> <leader>d <Plug>(coc-definition)
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" }}}

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
let g:ale_virtualtext_cursor = 'disabled' " disable virtual text

let g:ale_fixers = {
\       "python": ["black", "ruff"],
\}

nmap <leader>f <Plug>(ale_fix)
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

" FZF {{{

let $FZF_DEFAULT_COMMAND = "rg --files --hidden --no-ignore"

nnoremap <silent> <C-P> :GFiles<CR>
nnoremap <silent> <C-F> :Files<CR>

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

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

" Nginx Auto-complete configuration {{{
augroup custom_nginx
  autocmd!
  autocmd FileType nginx setlocal iskeyword+=$
  autocmd FileType nginx let b:coc_additional_keywords = ['$']
augroup end
" }}}

" vim-trailing-whitespace {{{
augroup fix_whitespace_save
  let blacklist = ['markdown', 'vim']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | execute ':FixWhitespace' | endif
augroup END
" }}}

" FGA {{{

" Initialize FGA plugin directly rather than in a function
lua <<EOF
require('fga').setup({
  install_treesitter_grammar = true,
})
EOF

" }}}

" Claude Code {{{

lua << EOF
require('claude-code').setup({
  command = "CLAUDE_CODE_USE_BEDROCK=1 claude",
  window = {
    position = "float",  -- Position of the window: "botright", "topleft", "vertical", "float", etc.
    -- Floating window configuration (only applies when position = "float")
    float = {
      width = "90%",        -- Width: number of columns or percentage string
      height = "90%",       -- Height: number of rows or percentage string
      row = "center",       -- Row position: number, "center", or percentage string
      col = "center",       -- Column position: number, "center", or percentage string
      relative = "editor",  -- Relative to: "editor" or "cursor"
      border = "rounded",   -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
    },
    keymaps = {
      toggle = {
        normal = "<C-,>",       -- Normal mode keymap for toggling Claude Code, false to disable
        terminal = "<C-,>",     -- Terminal mode keymap for toggling Claude Code, false to disable
        variants = {
          continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
          verbose = "<leader>cV",  -- Normal mode keymap for Claude Code with verbose flag
        },
      },
      window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
      scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
    },
  },
})
EOF

" }}}

" Presenting {{{

function! Present()
lua <<EOF
require('presenting').setup {
  cmd = { "Presenting" },
}
EOF
endfunction
augroup vimenter
  autocmd! VimEnter * call Present()
augroup END
" }}}

" Writing formatting {{{
augroup write_formatting
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
