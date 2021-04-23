-- Aliases
local command = vim.api.nvim_command
local keymap = vim.api.nvim_set_keymap
local exec = vim.api.nvim_exec

local g = vim.g
local o = vim.o
local wo = vim.wo

-- Set leader key to space
keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
g.mapleader = ' '
g.maplocalleader = ' '

local nvim_root = vim.fn.stdpath('config')
local cache_root = vim.fn.stdpath('cache')
local data_path = vim.fn.stdpath('data')
local packer_install_path = data_path .. '/site/pack/packer/start/packer.nvim'

-- Install packer if it is not installed already
if not vim.fn.isdirectory(packer_install_path) then
    command('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_install_path)
end

-- Make sure cache subdirs exist
local cache_dirs = { '/tags', '/backup', '/undo', '/swap' }
for i = 1, #cache_dirs do
    local dir = cache_root .. cache_dirs[i]
    if not vim.fn.isdirectory(dir) then
        vim.fn.mkdir(dir)
    end
end

-- Recompile packer on editing init.lua
exec([[
    augroup packer
        autocmd!
        autocmd BufWritePost init.lua PackerCompile
    augroup end
]], false)

require('packer').startup(function()
    local use = require('packer').use

    -- Package manager
    use 'wbthomason/packer.nvim'
    -- Colorscheme
    use 'arcticicestudio/nord-vim'
    -- Syntax highighting
    use 'sheerun/vim-polyglot'
    -- Make commenting easier
    use 'tomtom/tcomment_vim'
    -- Highlight hex colors with the actual color
    use 'lilydjwg/colorizer'
    -- Navigate with tmux easily
    use 'christoomey/vim-tmux-navigator'
    -- Now where the root of the project is always
    use 'dbakker/vim-projectroot'
    -- Match pairs like "" or ()
    use 'jiangmiao/auto-pairs'
    -- Create a motion of surrounding pairs
    use 'tpope/vim-surround'
    -- Repeat work good
    use 'tpope/vim-repeat'
    -- Collection of configurations for built-in LSP client
    use 'neovim/nvim-lspconfig'
    -- Autocomplete plugin
    use 'hrsh7th/nvim-compe'
    -- Add indentation guides even on blank lines
    use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }
    -- UI to select things (files, grep results, open buffers...)
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
    -- Add git related info in the signs columns and popups
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
    -- Extra syntax highlighting goodness
    use 'nvim-treesitter/nvim-treesitter'
    -- Fancy statusline
    use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
end)

-- Incremental live completion
o.inccommand = 'split'

-- Set highlight on search
o.hlsearch = true
o.incsearch = true

-- Set relative/absolute line numbering
wo.number = true
wo.relativenumber = true

-- Do not save when switching buffers
o.hidden = true

-- Enable mouse
o.mouse = 'a'

-- Indent settings
o.breakindent = true
o.autoindent = true
o.smarttab = true
o.expandtab = true
o.shiftround = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- Enable/Disable undo/backup/swap
vim.cmd[[set undofile]]
o.backup = true
o.swapfile = true
o.undoreload = 10000
o.undodir = cache_root .. '/undo//'
o.backupdir = cache_root .. '/backup//'
o.directory = cache_root .. '/swap//'

-- Timeout settings
o.timeout = true
o.ttimeout = true
o.timeoutlen = 600
o.ttimeoutlen = 0

-- Search settings
o.ignorecase = true
o.smartcase = true
o.gdefault = true
o.showmatch = true

-- Do not show mode in prompt
o.showmode = false

-- List character settings
o.list = true
o.listchars = 'extends:»,precedes:«,tab:│·,eol:¬,nbsp:.,trail:.'

-- Wildmenu settings
o.wildmenu = true
o.wildignorecase = true
o.wildmode = 'list:longest'
o.wildignore = '*/.git/*,*/.hg/*,*/.svn/*,*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.mp3,*.wav,*.wav,*.class,*.o,*.pyc'

-- Do not display certain messages in prompt
o.shortmess = o.shortmess .. 'c'

-- Fold handling settings
o.foldmethod = 'marker'
o.foldnestmax = 10

-- Change preview window location
o.splitbelow = true

-- Word wrap disable
vim.cmd[[set nowrap]]

-- Set completeopt to have a better completion experience
o.completeopt="menuone,noinsert,noselect"

-- Set title of tabs
o.titlestring = '%t'

-- Indent blankline plugin settings
g.indent_blankline_char = "|"
g.indent_blankline_filetype_exclude = { 'help', 'packer' }
g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
g.indent_blankline_char_highlight = 'LineNr'

-- Python host prog settings
g.python_host_prog = '$HOME/.pyenv/versions/neovim2/bin/python'
g.python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'

-- Color settings
o.termguicolors = true
vim.cmd[[colorscheme nord]]

-- TODO: why no work
-- exec([[
--     hi Normal guibg=NONE ctermbg=NONE
--     hi SignColumn guibg=NONE ctermbg=NONE
--     hi NonText guibg=NONE ctermbg=NONE
--     hi LineNr guibg=NONE ctermbg=NONE
--     hi Folded guibg=NONE guifg=7 ctermbg=NONE ctermfg=7
--     hi SpecialKey guibg=NONE ctermbg=NONE
--
--     hi TabLine ctermbg=0 ctermfg=15 guibg=#373b37
--     hi TabLineFill ctermbg=0 guibg=#373b37
--     hi TabLineSel ctermbg=8 ctermfg=15 guibg=#989898 guifg=#ffffff
--
--     hi Error NONE
--     hi ErrorMsg NONE
--
--     highlight ColorColumn ctermbg=0 guibg=#222222
--
--     hi statusline ctermfg=149 ctermbg=0 cterm=NONE
--     hi statusline guifg=Black guibg=Grey guisp=NONE
-- ]], false)

-- List of files that identify a root directory
g.rootmarkers = {
    '.projectroot',
    '.git'
}

-- CD to project root on buffer enter
exec([[
    augroup cd_to_project_root
        autocmd!
        autocmd BufEnter * call ProjectRootCD()
    augroup end
]], false)

-- Unmap tcomment default maps
g.tcomment_mapleader1 = ''
g.tcomment_mapleader2 = ''

-- Unmap colorizer default maps
g.colorizer_nomap = 1

-- Telescope settings
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ['<esc>'] = actions.close
      },

      n = {
          ['<esc>'] = actions.close
      }
    },
    generic_sorter =  sorters.get_fzy_sorter,
    file_sorter =  sorters.get_fzy_sorter,
  }
}

--Add leader shortcuts
keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true})
keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})

-- Gitsigns settings
require('gitsigns').setup()

-- Compe settings
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = false;
    calc = true;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = false;
    snippets_nvim = true;
    treesitter = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Tree-sitter settings
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'python',
        'php'
    },

    highlight = {
        enable = true
    }
}

-- Lualine settings
require('nvim-web-devicons').setup()

require('lualine').setup {
    options = {
        theme = 'nord',
        section_separators = '',
        component_separators = ''
    }
}

-- LSP settings
local lspconfig = require('lspconfig')

local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Disable diagnostics. I know what I'm doing, maybe
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false,
        update_in_insert = false
    }
)

-- Enable python lsp server
lspconfig['pyright'].setup {
    cmd = { data_path .. '/lsp_servers/python/node_modules/.bin/pyright-langserver', '--stdio' },
    on_attach = on_attach
}

-- Enable bash lsp server
lspconfig['bashls'].setup {
    cmd = { data_path .. '/lsp_servers/bash/node_modules/.bin/bash-language-server', 'start' },
    on_attach = on_attach
}

-- Remeber where the curser was when reopening a file
exec([[
    augroup remember_cursor_position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup end
]], false)

--Remap escape to leave terminal mode
exec([[
    augroup terminal
        autocmd!
        autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
        autocmd TermOpen * set nonu
    augroup end
]], false)

-- Highlight on yank
exec([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]], false)

-- Unmap these for my sanity
keymap('i', '<F1>', '<nop>', { noremap = true })
keymap('n', '<F1>', '<nop>', { noremap = true })
keymap('v', '<F1>', '<nop>', { noremap = true })
keymap('n', 'Q', '<nop>', { noremap = true })
keymap('n', 'q:', '<nop>', { noremap = true })

-- Windows splits
keymap('n', '<leader>-', ':<C-u>split<cr>', { noremap = true })
keymap('n', '<leader>\\', ':<C-u>vsplit<cr>', { noremap = true })

-- Switch windows painlessly
keymap('n', '<C-h>', '<C-w>h', { noremap = true })
keymap('n', '<C-j>', '<C-w>j', { noremap = true })
keymap('n', '<C-k>', '<C-w>k', { noremap = true })
keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Indent in visual mode and maintain cursor position
keymap('v', '>', 'md>`d:delm d<cr>gv', { noremap = true, silent = true })
keymap('v', '<', 'md<`d:delm d<cr>gv', { noremap = true, silent = true })

-- Keep search matches in the middle of the window
keymap('n', 'n', 'nzzzv', { noremap = true })
keymap('n', 'N', 'Nzzzv', { noremap = true })

-- Remove highlighting
keymap('n', '\\', ':nohl<cr>', { noremap = true, silent = true })

--Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap= true, expr = true, silent = true })

-- Y yank until the end of line
keymap('n', 'Y', 'y$', { noremap = true })
