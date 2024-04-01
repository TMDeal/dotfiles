return {
  { "catppuccin/nvim", name = "catppuccin", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "shaunsingh/nord.nvim",
    config = function()
      -- require("nord").setup({
      --   transparent = false,
      --   borders = true,
      -- })

      -- vim.cmd.colorscheme("nord")
      vim.g.nord_contrast = false
      vim.g.nord_borders = true
      vim.g.nord_bold = true
      vim.g.nord_disable_background = true
      vim.g.nord_cursorline_transparent = false
      vim.g.nord_enable_sidebar_background = false
      vim.g.nord_italic = true
      vim.g.nord_uniform_diff_background = true
    end,
  },
}
