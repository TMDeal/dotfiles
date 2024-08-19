return {
  { "catppuccin/nvim", name = "catppuccin", enabled = false },
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
