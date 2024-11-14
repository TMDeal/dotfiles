return {
  {
    "rafamadriz/friendly-snippets",
    commit = "9a91957168c0ba4b14291d9ebefc83a36165d1b8",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
