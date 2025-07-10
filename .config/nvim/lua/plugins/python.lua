return {
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   opts = {
  --     settings = {
  --       options = {
  --         notify_user_on_venv_activation = false,
  --       },
  --     },
  --   },
  -- },
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
        vim.list_extend(opts.ensure_installed, { "pyright", "ruff" })
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = { "ruff_fix", "ruff_format" },
        ["htmldjango"] = { "djlint" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ["python"] = { "ruff", "mypy" },
        ["htmldjango"] = { "djlint" },
      },
    },
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
