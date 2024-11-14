return {
  "jay-babu/project.nvim",
  name = "project_nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    manual_mode = false,
    detection_methods = { "pattern", "lsp" },
    patterns = {
      ".git",
      "venv",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
      "package.json",
      ".projectroot",
      "go.mod",
      "mix.exs",
      "mix.lock",
    },
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("lazyvim.util").on_load("telescope.nvim", function()
      require("telescope").load_extension("projects")
    end)
  end,
  keys = {
    { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
  },
}
