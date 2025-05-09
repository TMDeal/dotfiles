return {
  { "folke/tokyonight.nvim", enabled = false },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    opts = {
      flavor = "frappe",
      background = { dark = "frappe" },
    },
  },

  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
      vim.cmd.colorscheme("nord")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
