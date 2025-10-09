return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "toml", "htmldjango" } },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "ruff", "pyright" } },
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
}
