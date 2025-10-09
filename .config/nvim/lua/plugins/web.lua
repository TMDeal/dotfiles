return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "css", "html" } },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "cssls", "html", "ts_ls", "eslint" } },
  },
}
