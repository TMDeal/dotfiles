return {
  {
    "linux-cultist/venv-selector.nvim",
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
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml", "htmldjango" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "pyright" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ruff-lsp", "djlint", "black", "isort" })
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end

      -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
      if not opts.handlers then
        opts.handlers = {}
      end
      opts.handlers.python = function() end
    end,
  },
}
