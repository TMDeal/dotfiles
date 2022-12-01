local opt = vim.opt
local cache_root = vim.fn.stdpath('cache')

-- Make sure cache subdirs exist
local cache_dirs = { '/tags', '/backup', '/undo', '/swap' }
for i = 1, #cache_dirs do
    local dir = cache_root .. cache_dirs[i]
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir)
    end
end

-- Set default shell
opt.shell = "/bin/zsh"

-- Incremental live completion
opt.inccommand = 'split'

-- Set highlight on search
opt.hlsearch = true
opt.incsearch = true

-- Set relative/absolute line numbering
opt.number = true
opt.relativenumber = true

-- Do not save when switching buffers
opt.hidden = true

-- Enable mouse
opt.mouse = 'a'

-- Indent settings
opt.breakindent = true
opt.autoindent = true
opt.smarttab = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

-- Enable/Disable undo/backup/swap
opt.undofile = true
opt.backup = true
opt.swapfile = true
opt.undoreload = 10000
opt.undodir = cache_root .. '/undo//'
opt.backupdir = cache_root .. '/backup//'
opt.directory = cache_root .. '/swap//'

-- Timeout settings
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 0

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.showmatch = true

-- Do not show mode in prompt
opt.showmode = false

-- List character settings
opt.list = true
opt.listchars = 'extends:»,precedes:«,tab:│·,eol:¬,nbsp:.,trail:.'

-- Wildmenu settings
opt.wildmenu = true
opt.wildignorecase = true
opt.wildmode = 'list:longest'
opt.wildignore = '*/.git/*,*/.hg/*,*/.svn/*,*.bmp,*.gif,*.mp3,*.wav,*.wav,*.class,*.o,*.pyc'

-- Do not display certain messages in prompt
opt.shortmess:append('c')

-- Fold handling settings
-- opt.foldmethod = 'marker'
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldnestmax = 10
opt.foldlevel=99

-- Change preview window location
opt.splitbelow = true
opt.splitright = true

-- Word wrap disable
opt.wrap = false

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noinsert,noselect"

-- Set title of tabs
opt.titlestring = '%t'

-- Enable extra colors in terminal
opt.termguicolors = true
opt.guifont = "Anonymice Nerd Font:h8"

-- Enable python remote-plugins for python3
vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python"

-- session settings for autosession.nvim
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
