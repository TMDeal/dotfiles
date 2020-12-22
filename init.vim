"{{{ Leader
nnoremap <SPACE> <NOP>
let g:mapleader="\<SPACE>"
let g:maplocalleader="\<SPACE>"
"}}}

"{{{ Environment Variables
let $EDITOR_ROOT=expand("$HOME/.config/nvim")
let $CACHE_DIR=expand("$EDITOR_ROOT/.cache")
let $PLUGGED_DIR=expand("$EDITOR_ROOT/plugged")
"}}}

"{{{ Plug Setup
let plug_file=expand('$EDITOR_ROOT/autoload/plug.vim')
let curl_cmd=expand('curl')

if !filereadable(plug_file)
    if !executable(curl_cmd)
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent exec "!"curl_cmd" -fLo " . shellescape(plug_file) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    autocmd VimEnter * PlugInstall
endif
"}}}

"{{{ Cache
if !isdirectory(expand($CACHE_DIR))
    call mkdir(expand($CACHE_DIR))
endif

for s:dir in ['tags', 'backup', 'undo', 'swap']
    if !isdirectory(expand($CACHE_DIR . '/' .s:dir))
        call mkdir(expand($CACHE_DIR . '/' .s:dir))
    endif
endfor
"}}}

"{{{ Plugins
call plug#begin($PLUGGED_DIR)

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

if isdirectory(expand('$HOME/.fzf'))
    Plug '~/.fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'ojroques/nvim-lspfuzzy'
endif

Plug 'arcticicestudio/nord-vim'

Plug 'dbakker/vim-projectroot'
let g:rootmarkers=[
            \'.projectroot',
            \'.git',
            \]

Plug 'itchyny/vim-gitbranch'

Plug 'itchyny/lightline.vim'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'jiangmiao/auto-pairs'

Plug 'tomtom/tcomment_vim'
let g:tcomment_mapleader1=''
let g:tcomment_mapleader2=''

Plug 'lilydjwg/colorizer'
let g:colorizer_nomap=1

Plug 'christoomey/vim-tmux-navigator'

call plug#end()
"}}}

"{{{ Functions
function! AutoCDtoProjectRoot()
    try
        if &ft != 'help'
            ProjectRootCD
        endif
    catch
        "silently ignore invalid buffers
    endtry
endfun

function! StatusLineGit()
    let l:branchname = gitbranch#name()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! StatusLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! StatusLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! StatusLineFileformat()
    return winwidth(0) > 80 ? &fileformat : ''
endfunction

function! StatusLineFiletype()
    return winwidth(0) > 80 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLineFileencoding()
    return winwidth(0) > 80 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! StatusLineFilename()
    let fname = expand('%:t')
    return fname =~ 'NERD_tree\|undotree*\|diffpanel*' ? '' :
                \ ('' != StatusLineReadonly() ? StatusLineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != StatusLineModified() ? ' ' . StatusLineModified() : '')
endfunction

function! StatusLineMode()
    let fname = expand('%:t')
    return fname =~ 'diffpanel*' ? 'Diffpanel' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"}}}

"{{{ Settings
let g:python_host_prog='$HOME/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog='$HOME/.pyenv/versions/neovim3/bin/python'

set encoding=utf-8
set backspace=indent,eol,start
set history=10000
set autoread
set laststatus=2
set t_vb=
set t_u7=

set inccommand=split
set titlestring=%t
set mouse=a
set completeopt=menuone,noinsert,noselect
set number
set relativenumber
set sidescroll=1
set showcmd
set title
set autowrite
set hidden
set nowrap
set cmdheight=1
set mousehide
set noerrorbells
set novisualbell
set splitbelow
set splitright
set foldmethod=marker
set foldnestmax=10
set updatetime=1000
set ruler
set shortmess+=c
set diffopt+=vertical
set pumheight=10
set showtabline=1
set list
set listchars=extends:»,precedes:«
set listchars+=tab:│·,eol:¬
set listchars+=nbsp:.,trail:.
set noshowmode

set autoindent
set smarttab
set expandtab
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=4

set timeout
set ttimeout
set timeoutlen=600
set ttimeoutlen=0

set hlsearch
set incsearch

set ignorecase
set smartcase
set gdefault
set showmatch

set undofile
set undoreload=10000
set undodir=$EDITOR_ROOT/.cache/undo//
set backupdir=$EDITOR_ROOT/.cache/backup//
set directory=$EDITOR_ROOT/.cache/swap//
set backup
set noswapfile

set wildmenu
set wildmode=list:longest
set wildignorecase
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.mp3,*.wav,*.wav
set wildignore+=*.class,*.o,*.pyc
"}}}

"{{{ FZF
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir='$HOME/.config/nvim/.cache/fzf-history'

let g:fzf_layout = {'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'Comment', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS='--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fd
"}}}

"{{{ Colors
if !has($TMUX) && has('termguicolors')
    set termguicolors
endif

set background=dark
set t_Co=256
colorscheme nord

hi Normal guibg=None
hi Normal guibg=NONE
hi SignColumn guibg=NONE
hi NonText guibg=NONE
hi LineNr guibg=NONE
hi Folded guibg=NONE guifg=7
hi SpecialKey guibg=NONE

hi Normal ctermbg=NONE
hi SignColumn ctermbg=NONE
hi NonText ctermbg=NONE
hi LineNr ctermbg=NONE
hi Folded ctermbg=NONE ctermfg=7
hi SpecialKey ctermbg=NONE

hi TabLine ctermbg=0 ctermfg=15 guibg=#373b37
hi TabLineFill ctermbg=0 guibg=#373b37
hi TabLineSel ctermbg=8 ctermfg=15 guibg=#989898 guifg=#ffffff

hi Error NONE
hi ErrorMsg NONE

highlight ColorColumn ctermbg=0 guibg=#222222

hi statusline ctermfg=149 ctermbg=0 cterm=NONE
hi statusline guifg=Black guibg=Grey guisp=NONE
"}}}

" {{{ LSP 
:lua << EOF
   local lspconfig = require('lspconfig')
   local lspfuzzy = require('lspfuzzy')

   local on_attach = function(client)
       require('completion').on_attach(client)
   end

   lspfuzzy.setup({})

   lspconfig.pyls.setup({ on_attach=on_attach })

   lspconfig.bashls.setup({ on_attach=on_attach })
EOF

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> g[    <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g]    <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" }}}

"{{{ Mappings
" For my sanity
" tnoremap <ESC> <C-\><C-n><C-w><C-p>
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap q: <nop>

" completion-nvim 
imap <silent> <C-Space> <Plug>(completion_trigger)
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Window splits
nnoremap <Leader>- :<C-u>split<CR>
nnoremap <Leader>\ :<C-u>vsplit<CR>

" Tabs
nnoremap <silent> tn :tabnew<CR>
nnoremap <silent> t[ :tabprevious<CR>
nnoremap <silent> t] :tabnext<CR>

" Switching windows
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j 
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l 

" indent in visual mode and maintain cursor position
vnoremap <silent> > md>`d:delm d<cr>gv
vnoremap <silent> < md<`d:delm d<cr>gv

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" File search/replace template
nnoremap gs :%s//c<left><left>

" Removes highlighting.
nnoremap <silent> \ :nohl<cr>
"}}}

"{{{ Lightline
let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [[ 'mode', 'paste' ], [ 'git', 'filename' ]],
            \   'right': [[ 'percent' ],
            \             [ 'fileformat', 'fileencoding', 'filetype' ]],
            \ },
            \ 'component_function': {
            \   'git': 'StatusLineGit',
            \   'filename': 'StatusLineFilename',
            \   'fileformat': 'StatusLineFileformat',
            \   'filetype': 'StatusLineFiletype',
            \   'fileencoding': 'StatusLineFileencoding',
            \   'mode': 'StatusLineMode',
            \ },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }
"}}}

"{{{ Autocmd Rules
augroup remember_cursor_position
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup cd_to_project_root
    au!
    au BufEnter * call AutoCDtoProjectRoot()
augroup END

augroup terminal_escape
    au!
    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au FileType fzf tunmap <buffer> <Esc>
augroup END
""}}}
