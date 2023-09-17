return {
  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      local button = require("astronvim.utils").alpha_button

      dashboard.section.buttons.val = {
        button("SPC n", "  new file"),
        button("SPC f f", "  Find File"),
        button("SPC f o", "  Recent Files"),
        button("SPC f w", "  Find Word"),
        button("SPC f '", "  Bookmarks"),
        button("SPC S l", "  Last Session"),
        button("SPC q", "  Quit"),
      }

      return dashboard
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      local filters = {}
      dap.defaults.python.exception_breakpoints = filters
    end,
  },
  {
    "lambdalisue/suda.vim",
    cmd = "SudaWrite",
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
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
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#2e3440",
      fps = 30,
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 250,
    },
  },
  {
    "aserowy/tmux.nvim",
    lazy = false,
    opts = {
      copy_sync = {
        enable = true,
        ignore_buffers = { empty = false },
        redirect_to_clipboard = false,
        register_offset = 0,
        sync_clipboard = false,
        sync_registers = true,
        sync_deletes = true,
        sync_unnamed = true,
      },
      navigation = {
        cycle_navigation = true,
        enable_default_keybindings = true,
        persist_zoom = false,
      },
      resize = {
        enable_default_keybindings = true,
        resize_step_x = 1,
        resize_step_y = 1,
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    opts = {
      path = "append",
    },
  },
}
