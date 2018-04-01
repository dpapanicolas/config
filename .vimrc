
" ----------------------------------------------------------------------------
" OPTIONS
" ----------------------------------------------------------------------------
"

set autoindent              " Carry over indenting from previous line
set autoread                " Don't bother me hen a file changes
set autowrite               " Write on :next/:prev/^Z
set backspace=indent,eol,start
                            " Allow backspace beyond insertion point
set cindent                 " Automatic program indenting
set cinkeys-=0#             " Comments don't fiddle with indenting
set cino=                   " See :h cinoptions-values
set copyindent              " Make autoindent use the same chars as prev line
set directory-=.            " Don't store temp files in cwd
set encoding=utf8           " UTF-8 by default
set expandtab               " No tabs
set fileformats=unix,dos,mac  " Prefer Unix
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,fold:-,diff:┄
                            " Unicode chars for diffs/folds, and rely on
                            " Colors for window borders
set foldmethod=indent       " Use braces by default
set formatoptions=tcqn1     " t - autowrap normal text
                            " c - autowrap comments
                            " q - gq formats comments
                            " n - autowrap lists
                            " 1 - break _before_ single-letter words
                            " 2 - use indenting from 2nd line of para
set hidden                  " Don't prompt to save hidden windows until exit
set history=200             " How many lines of history to save
set hlsearch                " Hilight searching
set ignorecase              " Case insensitive
set incsearch               " Search as you type
set infercase               " Completion recognizes capitalization
set laststatus=2            " Always show the status bar
set linebreak               " Break long lines by word, not char
set list                    " Show whitespace as special chars - see listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things
set matchtime=2             " Tenths of second to hilight matching paren
set modelines=5             " How many lines of head & tail to look for ml's
silent! set mouse=nvc       " Use the mouse, but not in insert mode
set nobackup                " No backups left after done editing
set nonumber                " No line numbers to start
set visualbell t_vb=        " No flashing or beeping at all
set nowritebackup           " No backups made while editing

set ruler                   " Show row/col and percentage
set scroll=4                " Number of lines to scroll with ^U/^D
set scrolloff=15            " Keep cursor away from this many chars top/bot
set sessionoptions-=options " Don't save runtimepath in Vim session (see tpope/vim-pathogen docs)
set shiftround              " Shift to certain columns, not just n spaces
set shiftwidth=2            " Number of spaces to shift for autoindent or >,<
set shortmess+=A            " Don't bother me when a swapfile exists
set showbreak=              " Show for lines that have been wrapped, like Emacs
set showmatch               " Hilight matching braces/parens/etc.
set sidescrolloff=3         " Keep cursor away from this many chars left/right
set smartcase               " Lets you search for ALL CAPS
set softtabstop=2           " Spaces 'feel' like tabs
set suffixes+=.pyc          " Ignore these files when tab-completing
set tabstop=2               " The One True Tab
set textwidth=100           " 100 is the new 80
set notitle                 " Don't set the title of the Vim window
set wildmenu                " Show possible completions on command line
set wildmode=list:longest,full " List all options and complete
set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules  " Ignore certain files in tab-completion

" Essential for filetype plugins.
filetype plugin indent on

" ----
"  MAPPINGS
" -----

let maplocalleader = ","
let mapleader = ","


" Useful macros I use the most"
nmap \E :set expandtab tabstop=2 softtabstop=2 shiftwidth=2<CR>
nmap \R :set expandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \T :set expandtab tabstop=8 softtabstop=8 shiftwidth=8<CR>
nmap \x :cclose<CR>
nmap \q :nohlsearch<CR>
nmap \c :call TmuxPaneClear()<CR>
nmap \r :call TmuxPaneRepeat()<CR>


" Quickly fix spelling errors choosing the first result

nmap <localeader>z z=1<CR><CR>

" Move between open buffers.
nmap <C-e> :e#<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

nnoremap <space> za
vnoremap <space> zf

" Super fast window movement shortcuts
" nmap <C-j> <C-W>j
" nmap <C-k> <C-W>k
" nmap <C-h> <C-W>h
" nmap <C-l> <C-W>l

"Search for the word under the cursor in the current directory
"
"
"
function Search() abort
  let saved_shellpipe = &shellpipe
    let &shellpipe =  '>'
      try
        execute 'Ack!' "<cword>"
      finally
        let &shellpipe = saved_shellpipe
      endtry
endfunction


nmap <M-k>    :call Search()<CR>
nmap <Esc>k   :call Search()<CR>
nmap \*       :call Search()<CR>

" These are things that I mistype and want ignored.
nmap Q  <silent>
nmap q: <silent>
nmap K  <silent>


" Make the cursor stay on the same line when window switching
function! KeepCurrentLine(motion)
  let theLine = line('.')
  let theCol = col('.')
  exec 'wincmd ' . a:motion
  if &diff
    call cursor(theLine, theCol)
  endif
endfunction
nnoremap <C-w>h :silent call KeepCurrentLine('h')<CR>
nnoremap <C-w>l :silent call KeepCurrentLine('l')<CR>



" ---
"  PLUGS
"  ----


call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'altercation/vim-colors-solarized'
Plug 'lervag/vimtex'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
"Plug 'bling/vim-airline'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'flazz/vim-colorschemes'

Plug 'valloric/youcompleteme'

call plug#end()

"vimtex
let g:vimtex_view_method = "skim"
let g:vimtex_complete_enabled = 1
"Too slow so turn this off
let g:vimtex_matchparen_enabled = 0


if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:ycm_max_num_candidates = 20
"Effectively kilz
let g:ycm_min_num_of_chars_for_completion = 20



"Remap the buffers command
nmap ; :Buffers<CR>
nmap \f :Files<CR>


if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" " ALE
let g:ale_sign_column_always = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = 'X'
let g:ale_completion_enable=0
let g:ale_lint_on_text_change = 'normal'
let g_ale_lint_delay=300 "After a second run it


highlight link ALEWarningSign String
highlight link ALEErrorSign Error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" Lightline
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'linter_warnings', 'linter_errors', 'linter_ok' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK'
      \ },
      \ 'component_type': {
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'ok'
      \ },
      \ }

autocmd User ALELint call lightline#update()

" ale + lightline
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ▲', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d X', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

" ----------------------------------------------------------------------------
" COLORS
" ----------------------------------------------------------------------------

" Make sure colored syntax mode is on, and make it Just Work with 256-color terminals.
set background=dark
let g:rehash256 = 1 " Something to do with Molokai?
colorscheme molokai
if !has('gui_running')
  if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
  elseif has("terminfo")
    colorscheme default
    set t_Co=8
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm
  else
    colorscheme default
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif
  " Disable Background Color Erase when within tmux - https://stackoverflow.com/q/6427650/102704
  if $TMUX != ""
    set t_ut=
  endif
endif
syntax on


" Some custom spell-checking colors
highlight SpellBad     term=underline cterm=underline ctermbg=NONE ctermfg=205
highlight SpellCap     term=underline cterm=underline ctermbg=NONE ctermfg=33
highlight SpellRare    term=underline cterm=underline ctermbg=NONE ctermfg=217
highlight SpellLocal   term=underline cterm=underline ctermbg=NONE ctermfg=72


" The Ignore color should be... ignorable
silent! highlight Ignore cterm=bold ctermfg=black ctermbg=bg
highlight clear FoldColumn
highlight def link FoldColumn Ignore
highlight clear Folded
" highlight link Folded Ignore
highlight clear LineNr
highlight! def link LineNr Ignore

" Custom search colors
" highlight clear Search
" highlight Search term=NONE cterm=NONE ctermfg=white ctermbg=black

" Make hilighted matching parents less annoying
highlight clear MatchParen
highlight link MatchParen Search

" Make trailing spaces very visible
highlight SpecialKey ctermbg=Yellow guibg=Yellow

" ----------------------------------------------------------------------------
" FILE TYPE TRIGGERS
" ----------------------------------------------------------------------------

" Reset all autocommands
augroup vimrc
autocmd!

au BufNewFile,BufRead *.cuh     set ft=c
au BufNewFile,BufRead *.cson    set ft=coffee
au BufNewFile,BufRead *.glsl    setf glsl
au BufNewFile,BufRead *.gyp     set ft=python
au BufNewFile,BufRead *.html    setlocal nocindent smartindent
au BufNewFile,BufRead *.i7x     setf inform7
au BufNewFile,BufRead *.ini     setf conf
au BufNewFile,BufRead *.input   setf gnuplot
au BufNewFile,BufRead *.json    set ft=json tw=0
au BufNewFile,BufRead *.less    setlocal ft=less nocindent smartindent
au BufNewFile,BufRead *.md      setlocal ft=markdown nolist spell
au BufNewFile,BufRead *.md,*.markdown setlocal foldlevel=999 tw=0 nocin
au BufNewFile,BufRead *.ni      setlocal ft=inform nolist ts=2 sw=2 noet
au BufNewFile,BufRead *.plist   setf xml
au BufNewFile,BufRead *.rb      setlocal noai
au BufNewFile,BufRead *.rxml    setf ruby
au BufNewFile,BufRead *.sass    setf sass
au BufNewFile,BufRead *.ttml    setf xml
au BufNewFile,BufRead *.vert,*.frag set ft=glsl
au BufNewFile,BufRead *.xml     setlocal ft=xml  ts=2 sw=2 et
au BufNewFile,BufRead *.zone    setlocal nolist ts=4 sw=4 noet
au BufNewFile,BufRead *.zsh     setf zsh
au BufNewFile,BufRead *.text    setlocal nolist spell
au BufNewFile,BufRead *.tex    setlocal nolist spell
au BufNewFile,BufRead *.tex   let b:ale_enabled = 0
au BufNewFile,BufRead *templates/*.html setf htmldjango
au BufNewFile,BufRead .git/config setlocal ft=gitconfig nolist ts=4 sw=4 noet
au BufNewFile,BufRead .gitconfig* setlocal ft=gitconfig nolist ts=4 sw=4 noet
au BufNewFile,BufRead .vimlocal,.gvimlocal setf vim
au BufNewFile,BufRead .zshlocal setf zsh
au BufNewFile,BufRead /tmp/crontab* setf crontab
au BufNewFile,BufRead COMMIT_EDITMSG setlocal nolist nonumber
au BufNewFile,BufRead Makefile setlocal nolist

au FileType gitcommit setlocal nolist ts=4 sts=4 sw=4 noet
au FileType inform7 setlocal nolist tw=0 ts=4 sw=4 noet foldlevel=999
au FileType json setlocal conceallevel=0 foldmethod=syntax foldlevel=999
au FileType make setlocal nolist ts=4 sts=4 sw=4 noet
au FileType markdown syn sync fromstart
au Filetype gitcommit setlocal tw=80

augroup END






