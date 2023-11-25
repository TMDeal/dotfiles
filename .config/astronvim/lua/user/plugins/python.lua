local utils = require "astronvim.utils"

return {
  {
    "mfussenegger/nvim-dap-python",
    opts = {
      include_configs = true,
    },
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      local dap_python = require "dap-python"
      dap_python.test_runner = "pytest"
      require("dap-python").setup(path, opts)
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    event = "VeryLazy",
    keys = { { "<leader>lv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    opts = {
      auto_refresh = false,
      search_venv_managers = true,
      search_workspace = true,
      search = true,
      dap_enabled = true,
      parents = 2,
      name = { "venv", ".venv" },
      fd_binary_name = "fdfind",
      notify_user_on_activate = false,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "toml",
        "htmldjango",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      utils.list_insert_unique(opts.ensure_installed, { "pyright" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      utils.list_insert_unique(opts.ensure_installed, { "flake8", "djlint", "black", "isort" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      utils.list_insert_unique(opts.ensure_installed, { "python" })

      -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
      if not opts.handlers then opts.handlers = {} end
      opts.handlers.python = function() end
    end,
  },
}
