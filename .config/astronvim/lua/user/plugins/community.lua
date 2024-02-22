return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.project.project-nvim" },

  { import = "astrocommunity.completion.cmp-cmdline" },

  { import = "astrocommunity.debugging.nvim-bqf" },

  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- { import = "astrocommunity.motion.flash-nvim" },
  -- {
  --   "folke/flash.nvim",
  --   opts = {
  --     modes = {
  --       char = {
  --         jump_labels = true,
  --       },
  --     },
  --   },
  -- },

  -- { import = "astrocommunity.utility.noice-nvim" },

  { import = "astrocommunity.colorscheme.nord-nvim" },

  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
}
