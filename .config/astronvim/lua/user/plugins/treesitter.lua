return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "windwp/nvim-ts-autotag", enabled = false },
    {
      "TMDeal/nvim-ts-autotag",
      name = "TMDeal-nvim-ts-autotag",
      opts = { autotag = { enable_close_on_slash = false } }
    }
  },
  opts = {
    highlight = {
      enable = true,
    },
    ensure_installed = {
      "lua",
      "html",
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
