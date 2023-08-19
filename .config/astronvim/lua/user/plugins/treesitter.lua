return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "windwp/nvim-ts-autotag", enabled = false },
    { "TMDeal/nvim-ts-autotag", name = "TMDeal-nvim-ts-autotag" }
  },
  opts = {
    ensure_installed = {
      "lua",
      "python",
      "markdown",
      "markdown_inline",
      "html",
      "htmldjango",
      "css",
      "javascript",
      "dockerfile",
      "json",
      "jsonc",
      "yaml",
      "toml",
      "bash",
    },
  },
}
