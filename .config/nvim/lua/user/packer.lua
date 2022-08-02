local fn = vim.fn
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    }

    vim.cmd [[packadd packer.nvim]]
end

-- Use protected call to avoid erroring out on first use
local ok, packer = pcall(require, "packer")
if not ok then
    return
end

-- Reload neovim whenever packer_init.lua is saved
autocmd("BufWritePost", {
    group = augroup("packer_user_config", { clear = true }),
    pattern = "packer.lua",
    callback = function()
        vim.cmd [[source <afile>]]
        packer.sync()
    end
})

-- Make packer use a floating window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

-- Start Packer
packer.startup(function(use)
    -- Plugins go here

    -- Have packer manage itself
    use "wbthomason/packer.nvim"

    -- Implementation of popup api from vim in neovim
    use "nvim-lua/popup.nvim"

    -- Prerequisite for most lua plugins
    use "nvim-lua/plenary.nvim"

    -- Make startup fastlike
    use "lewis6991/impatient.nvim"

    -- Integrate seamlessly with tmux
    use "aserowy/tmux.nvim"

    -- Sudo write/read inside vim
    use "lambdalisue/suda.vim"

    -- Colorschemes
    use "shaunsingh/nord.nvim"

    -- Improve the % operator
    use "andymass/vim-matchup"

    -- Improve Neovim UI
    use "stevearc/dressing.nvim"

    -- Autocompletion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "aspeddro/cmp-pandoc.nvim"
    use "onsails/lspkind.nvim"

    -- Snippets
    use "L3MON4D3/LuaSnip"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "ray-x/lsp_signature.nvim"

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.0',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        }
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end
    }

    use "Fymyte/rasi.vim"

    -- Sane indentation for python
    use "Vimjas/vim-python-pep8-indent"

    -- Set commentstring based on cursor position in file
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Close matching sets of (,",',} and so on
    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"

    -- Make commenting easier
    use "numToStr/Comment.nvim"

    -- Add git related info in the signs columns and popups
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }

    -- Highlight colorcodes to the color they represent
    use "norcalli/nvim-colorizer.lua"

    -- Visualise indent levels
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }

    -- Fancy Statusline
    use "nvim-lualine/lualine.nvim"

    -- Fancy Icons
    use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end
    }

    -- Enable surround motions
    use {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    }

    -- pandoc/markdown support
    use "aspeddro/pandoc.nvim"
    use 'vim-pandoc/vim-pandoc-syntax'
    use 'dhruvasagar/vim-table-mode'

    -- Leader Guide
    use 'folke/which-key.nvim'

    -- Know where the root of the project is always
    use 'ahmedkhalf/project.nvim'

    -- File Tree
    use "kyazdani42/nvim-tree.lua"

    -- Fancy tabline for buffers/tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use "kazhala/close-buffers.nvim"

    -- Open easy to use terminal
    use {
        "akinsho/toggleterm.nvim",
        tag = 'v2.*'
    }

    -- Startup menu
    use 'goolord/alpha-nvim'

    -- Note taking
    use "jakewvincent/mkdnflow.nvim"

    -- Pretty quickfix/loclist/diagnostics windows
    use "folke/trouble.nvim"

    -- Pretty notifications
    use "rcarriga/nvim-notify"

    -- yankring
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            {'kkharji/sqlite.lua', module = 'sqlite'},
        },
    }

    -- Code outline window
    use "stevearc/aerial.nvim"

    -- Show marks in gutter
    use "chentoast/marks.nvim"

    -- Better quickfix menu
    use "kevinhwang91/nvim-bqf"

    -- Automatically setup everything after cloning packer.nvim
    -- This should be after all plugins
    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
