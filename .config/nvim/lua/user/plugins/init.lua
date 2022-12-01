-- Install packer.nvim if not already installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
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
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
    pattern = "*/plugins/init.lua",
    callback = function()
        vim.cmd [[source <afile>]]
        packer.sync()
    end
})

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

packer.startup(function(use)
    -- Have packer manage itself
    use "wbthomason/packer.nvim"

    -- Make startup fastlike
    use {
        "lewis6991/impatient.nvim",
	config = function()
		require "impatient"
	end
    }

    -- Implementation of popup api from vim in neovim
    use "nvim-lua/popup.nvim"

    -- Prerequisite for most lua plugins
    use "nvim-lua/plenary.nvim"

    -- Integrate seamlessly with tmux
    use {
        "aserowy/tmux.nvim",
        config = function()
            require "user.plugins.configs.tmux"
        end
    }

    -- Sudo write/read inside vim
    use "lambdalisue/suda.vim"

    -- Colorschemes
    use {
        "shaunsingh/nord.nvim",
        config = function()
            vim.g.nord_contrast = false
            vim.g.nord_borders = true
            vim.g.nord_disable_background = true
            vim.g.nord_cursorline_transparent = false
            vim.g.nord_enable_sidebar_background = false
            vim.g.nord_italic = true
            vim.g.nord_uniform_diff_background = true

            require("nord").set()
            vim.cmd[[ colorscheme nord ]]
        end
    }

    -- Improve the % operator
    use "andymass/vim-matchup"

    -- Improve Neovim UI
    use "stevearc/dressing.nvim"

    -- Autocompletion
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            require "user.plugins.configs.cmp"
        end
    }
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

    -- Portable package manager for LSP,Dap,Linters,Formatters
    use {
        "williamboman/mason.nvim",
        config = function()
            require "user.plugins.configs.mason"
        end
    }

    use "williamboman/mason-lspconfig.nvim"

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        config = function()
            require "user.plugins.configs.lsp"
        end
    }

    use {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require "user.plugins.configs.null-ls"
        end
    }

    use "ray-x/lsp_signature.nvim"

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.0',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        },
        config = function()
            require "user.plugins.configs.telescope"
        end
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
        end,
        config = function()
            require "user.plugins.configs.treesitter"
        end
    }

    -- syntax for rofi theme configs
    use "Fymyte/rasi.vim"

    -- syntax for everything else
    use {
        "sheerun/vim-polyglot",
        setup = function()
            vim.g.polyglot_disabled = {
                "markdown"
            }
        end
    }

    -- Set commentstring based on cursor position in file
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Close matching sets of (,",',} and so on
    use {
        "windwp/nvim-autopairs",
        config = function()
            require "user.plugins.configs.autopairs"
        end
    }
    use "windwp/nvim-ts-autotag"

    -- Make commenting easier
    use {
        "numToStr/Comment.nvim",
        config = function()
            require "user.plugins.configs.comment"
        end
    }

    -- Add git related info in the signs columns and popups
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }

    use {
        "TimUntersberger/neogit",
        config = function()
            require("neogit").setup({
                integrations = {
                    diffview = true
                }
            })
        end
    }

    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    } 

    -- Add git blame info
    use {
        "f-person/git-blame.nvim"
    }

    -- manage github issues/pull requests, will set this up later. Looks hella nice
    use {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = function ()
            require("octo").setup()
        end
    }

    -- Highlight colorcodes to the color they represent
    use {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup {
                ["*"] = {
                    RGB = true,
                    RRGGBB  = true,
                    names = true,
                    RRGGBBAA = true,
                    rgb_fn = true,
                    hsl_fn = true,
                    css = true,
                    css_fn  = true,
                    mode = "background"
                }
            }
        end
    }

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
    use {
        "nvim-lualine/lualine.nvim",
        config = function()
            require "user.plugins.configs.lualine"
        end
    }

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
    use {
        "aspeddro/pandoc.nvim",
        config = function()
            require "user.plugins.configs.pandoc"
        end
    }

    use {
        "jakewvincent/mkdnflow.nvim",
        config = function()
            require "user.plugins.configs.mkdnflow"
        end
    }

    -- Plugin for hugo - forked from https://github.com/phelipetls/vim-hugo
    -- "TMDeal/hugo.nvim"
    -- use "~/my-workspace/hugo.nvim"

    -- Leader Guide
    use {
        'folke/which-key.nvim',
        config = function()
            require "user.plugins.configs.which-key"
        end
    }

    -- Know where the root of the project is always
    use {
        'ahmedkhalf/project.nvim',
        config = function()
            require "user.plugins.configs.project"
        end
    }

    -- File Tree
    use {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require "user.plugins.configs.nvim-tree"
        end
    }

    -- Fancy tabline for buffers/tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require "user.plugins.configs.bufferline"
        end
    }

    use "kazhala/close-buffers.nvim"

    -- Open easy to terminal
    use {
        "akinsho/toggleterm.nvim",
        tag = 'v2.*',
        config = function()
            require "user.plugins.configs.toggleterm"
        end
    }

    -- Startup menu
    use {
        'goolord/alpha-nvim',
        config = function()
            require "user.plugins.configs.alpha"
        end
    }

    -- Pretty quickfix/loclist/diagnostics windows
    use {
        "folke/trouble.nvim",
        config = function()
            require "user.plugins.configs.trouble"
        end
    }

    -- Pretty notifications
    use {
        "rcarriga/nvim-notify",
        config = function()
            require "user.plugins.configs.notify"
        end
    }

    -- yankring
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            {'kkharji/sqlite.lua', module = 'sqlite'},
        },
        config = function()
            require "user.plugins.configs.neoclip"
        end
    }

    -- Code outline window
    use {
        "stevearc/aerial.nvim",
        config = function()
            require "user.plugins.configs.aerial"
        end
    }

    -- Show marks in gutter
    use {
        "chentoast/marks.nvim",
        config = function()
            require "user.plugins.configs.marks"
        end
    }

    -- Better quickfix menu
    use {
        "kevinhwang91/nvim-bqf",
        config = function()
            require "user.plugins.configs.bqf"
        end
    }

    -- Automatically setup everything after cloning packer.nvim
    -- This should be after all plugins
    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
