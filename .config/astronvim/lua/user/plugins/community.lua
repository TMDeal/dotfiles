return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.project.project-nvim" },
  {
    "jay-babu/project.nvim",
    name = "project_nvim",
    lazy = false,
  },

  { import = "astrocommunity.debugging.nvim-bqf" },

  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },

  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
}
