-- Aliases
local command = vim.api.nvim_command
local keymap = vim.api.nvim_set_keymap
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local g = vim.g
local opt = vim.opt

-- Set leader key to space
keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
g.mapleader = ' '
g.maplocalleader = ' '

local cache_root = vim.fn.stdpath('cache')
local data_path = vim.fn.stdpath('data')
local packer_install_path = data_path .. '/site/pack/packer/start/packer.nvim'

-- Install packer if it is not installed already
if vim.fn.isdirectory(packer_install_path) == 0 then
    command('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_install_path)
end

-- Make sure cache subdirs exist
local cache_dirs = { '/tags', '/backup', '/undo', '/swap' }
for i = 1, #cache_dirs do
    local dir = cache_root .. cache_dirs[i]
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir)
    end
end

-- Recompile packer on editing init.lua
local packer_augroup = augroup("packer", { clear = true })
autocmd("BufReadPost", {
        group = packer_augroup,
        pattern = vim.env.MYVIMRC,
        callback = function()
            require('packer').compile()
        end
})

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
    use { 'lukas-reineke/indent-blankline.nvim' }
    -- UI to select things (files, grep results, open buffers...)
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
    -- Add git related info in the signs columns and popups
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
    -- Extra syntax highlighting goodness
    use { 'nvim-treesitter/nvim-treesitter', run = function()
        vim.cmd[[TSUpdate]]
    end}
    -- Fancy statusline
    use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
    -- pandoc/markdown support
    use 'vim-pandoc/vim-pandoc'
    use 'vim-pandoc/vim-pandoc-syntax'
    use 'dhruvasagar/vim-table-mode'
end)

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
opt.timeoutlen = 600
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
opt.wildignore = '*/.git/*,*/.hg/*,*/.svn/*,*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.mp3,*.wav,*.wav,*.class,*.o,*.pyc'

-- Do not display certain messages in prompt
opt.shortmess:append('c')

-- Fold handling settings
opt.foldmethod = 'marker'
opt.foldnestmax = 10

-- Change preview window location
opt.splitbelow = true

-- Word wrap disable
opt.wrap = false

-- Set completeopt to have a better completion experience
opt.completeopt="menuone,noinsert,noselect"

-- Set title of tabs
opt.titlestring = '%t'

-- Indent blankline plugin settings
g.indent_blankline_char = "|"
g.indent_blankline_filetype_exclude = { 'help', 'packer' }
g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
g.indent_blankline_char_highlight = 'LineNr'

-- Python host prog settings
g.python_host_prog = '$HOME/.pyenv/versions/neovim2/bin/python'
g.python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'

-- Color settings
opt.termguicolors = true
vim.cmd[[colorscheme nord]]

-- List of files that identify a root directory
g.rootmarkers = {
    '.projectroot',
    '.git'
}

-- CD to project root on buffer enter
local cd_to_project_root_augroup = augroup("cd_to_project_root", { clear = true })
autocmd("BufEnter", { group = cd_to_project_root_augroup, callback = function()
    vim.cmd[[call ProjectRootCD()]]
end
})

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
        'c',
        'bash',
        'python',
        'php',
        'ruby',
        'lua',
        'json',
        'toml'
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
        icons_enabled = false,
        section_separators = '',
        component_separators = ''
    }
}

-- Pandoc settings
g['pandoc#modules#disabled'] = {'folding', 'completion', 'spell'}

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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
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
local remember_last_position_augroup = augroup("remember_last_position_group", { clear = true })
autocmd("BufReadPost", {
        group = remember_last_position_augroup,
        callback = function()
            local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
            if {row, col} ~= {0, 0} then
                vim.api.nvim_win_set_cursor(0, {row, 0})
            end
        end
})

--Remap escape to leave terminal mode
local terminal_augroup = augroup("terminal", { clear = true })
autocmd("TermOpen", {
        group = terminal_augroup,
        callback = function()
            keymap("t", "<ESC>", "<c-\\><c-n>", { noremap = true })
        end
})

-- Highlight on yank
local yank_highlight_augroup = augroup("yank_highlight", { clear = true })
autocmd("TextYankPost", {
        group = yank_highlight_augroup,
        callback = function()
            vim.highlight.on_yank()
        end
})

-- Unmap these for my sanity
keymap('i', '<F1>', '<nop>', { noremap = true })
keymap('n', '<F1>', '<nop>', { noremap = true })
keymap('v', '<F1>', '<nop>', { noremap = true })
keymap('n', 'Q', '<nop>', { noremap = true })
keymap('n', 'q:', '<nop>', { noremap = true })

-- Windows splits
keymap('n', '<leader>-', ':<C-u>split<cr>', { noremap = true, silent = true })
keymap('n', '<leader>\\', ':<C-u>vsplit<cr>', { noremap = true, silent = true })

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
