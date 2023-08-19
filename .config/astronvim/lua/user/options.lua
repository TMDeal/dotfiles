-- Make sure cache subdirs exist
local cache_dirs = { "/tags", "/backup", "/undo", "/swap" }
local cache_root = vim.fn.stdpath "cache"

for i = 1, #cache_dirs do
  local dir = cache_root .. cache_dirs[i]
  if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir) end
end

return {
  opt = {
    shell = "/bin/zsh",
    inccommand = "split",
    hlsearch = true,
    incsearch = true,
    number = true,
    relativenumber = true,
    hidden = true,
    mouse = "a",
    breakindent = true,
    autoindent = true,
    smarttab = true,
    expandtab = true,
    shiftround = true,
    shiftwidth = 4,
    softtabstop = 4,
    tabstop = 4,
    undofile = true,
    backup = true,
    swapfile = true,
    undoreload = 10000,
    undodir = cache_root .. "/undo//",
    backupdir = cache_root .. "/backup//",
    directory = cache_root .. "/swap//",
    timeout = true,
    ttimeout = true,
    timeoutlen = 500,
    ttimeoutlen = 0,
    ignorecase = true,
    smartcase = true,
    gdefault = true,
    showmatch = true,
    showmode = false,
    list = true,
    listchars = "extends:»,precedes:«,tab:│·,eol:¬,nbsp:.,trail:.",
    wildmenu = true,
    wildignorecase = true,
    -- wildmode = 'list:longest',
    wildignore = "*/.git/*,*/.hg/*,*/.svn/*,*.bmp,*.gif,*.mp3,*.wav,*.wav,*.class,*.o,*.pyc",
    splitbelow = true,
    splitright = true,
    wrap = false,
    completeopt = "menuone,noinsert,noselect",
    titlestring = "%t",
    termguicolors = true,
    spell = false,
    signcolumn = "auto",
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    python3_host_prog = "~/.pyenv/versions/neovim3/bin/python",
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
