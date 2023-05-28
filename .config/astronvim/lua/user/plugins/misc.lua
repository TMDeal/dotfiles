return {
  {
    "lambdalisue/suda.vim",
    cmd = "SudaWrite",
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
  },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory"
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "venv", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".projectroot" },
    },
  },

  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = "toggleterm",
    },
  },
}
