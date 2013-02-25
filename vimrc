let mapleader = ","
" are we on a mac?

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let isMac = 1
  else
    let isMac = 0
  endif
endif

filetype off
" Get rid of vi compat crap
set nocompatible
set rtp+=~/.vim/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mileszs/ack.vim'
Bundle 'ddollar/nerdcommenter'
Bundle 'tsaleh/vim-align'
Bundle 'tpope/vim-repeat'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/Rename2'
Bundle 'tpope/vim-endwise'
Bundle 'Lokaltog/vim-powerline'
Bundle 'skalnik/vim-vroom'
Bundle 'mattn/zencoding-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'rorymckinley/vim-symbols-strings'
Bundle 'elubow/cql-vim'

" Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme="skwp"

set modelines=0

set number " line numbers
set ruler
set encoding=utf-8 " Encoding to UTF-8
let &t_Co=256 " tell vim terminal has 256 colors

" Whitespace and syntax stuff
syntax on
color hardcore
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set autoindent
set list listchars=tab:\ \ ,trail:·

filetype plugin indent on " indent depends on filetype
filetype plugin on

" misc
set visualbell
set ttyfast
set lazyredraw " buffer screen redraws instead of updating all the time

set hidden " Allow unsafed buffers
set wildignore+=gems/gems/*,doc/*,tmp/*,vendor/gems/*,.git,*.rbc,*.class,.svn,*.o,*.obj,public/assets/*,*.png,*.log,*.jpg,.bundle
set wildmenu
set wildmode=list:longest
set guifont="Monaco for Powerline":h12
set laststatus=2 " always display the status line
set showcmd
set scrolloff=3 " minimum lines to keep above and below cursor

" Search
set ignorecase " search case insensitive unless...
set smartcase  " ...search phrase contains a capital letter
set incsearch
set showmatch
set hlsearch " highlight searches and unhighlight search results with <space>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR> 
" Have sane search regexpes
nnoremap / /\v
vnoremap / /\v

" Movement
" Disable arrow keys for movement. Stick to hjkl
inoremap  <Up>     <ESC>:<UP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     :<UP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
" Have screen-line j/k instead of file-line
nnoremap j gj
nnoremap k gk
" use jj in insert mode to go back to normal mode
inoremap jj <ESC>
" Jump between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" make backtick behave like ' for marks
"nnoremap ` '

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Filetypes
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.cql set syntax=cql

if isMac
  " copy stuff to the macs clipboard
  vmap <leader>c "+y
endif

" Mappings
" Opens an edit command with the path of the currently edited file filled in
cnoremap %% <C-R>=expand("%:p:h")."/"<CR>
map <leader>e :e %%
" Switch between current and previous buffer
nnoremap <leader><leader> <c-^>

" Vim internals
" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set timeoutlen=250  " Time to wait after ESC
set nobackup
set noswapfile

if has("gui_running")
  " Automatically resize splits when resizing MacVim window
  autocmd VimResized * wincmd =
endif

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" fugitive configuration
nnoremap <C-g> :Gbrowse<CR>
nnoremap <C-b> :Gblame<CR>
" Plugins
" Syntastic
" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1
" supertab
" let g:SuperTabDefaultCompletionType = "context"
" CrtlP
map <leader>t :CtrlP<cr>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = "find %s -type f | egrep -v '/\.(git|hg|svn)|solr|tmp/'"
" YankRing
nnoremap <silent> <leader>z :YRShow<CR>

au WinLeave * set nocursorline
au WinEnter * set cursorline

" a little more informative version of the above
nmap <Leader>sI :call <SID>SynStack()<CR>

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
