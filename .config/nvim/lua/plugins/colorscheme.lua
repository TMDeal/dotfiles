return {
  { "catppuccin/nvim", name = "catppuccin", opts = { flavor = "frappe", background = { dark = "frappe" } } },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
      vim.cmd.colorscheme("nord")
    end,
  },
}
