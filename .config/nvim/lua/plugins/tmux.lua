return {
  "aserowy/tmux.nvim",
  keys = {
    {
      "<C-h>",
      function()
        require("tmux").move_left()
      end,
      mode = { "n" },
      desc = "Move to left window",
    },
    {
      "<C-j>",
      function()
        require("tmux").move_bottom()
      end,
      mode = { "n" },
      desc = "Move to bottom window",
    },
    {
      "<C-k>",
      function()
        require("tmux").move_top()
      end,
      mode = { "n" },
      desc = "Move to top window",
    },
    {
      "<C-l>",
      function()
        require("tmux").move_right()
      end,
      mode = { "n" },
      desc = "Move to right window",
    },
  },
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
      enable_default_keybindings = false,
      persist_zoom = false,
    },
    resize = {
      enable_default_keybindings = true,
      resize_step_x = 1,
      resize_step_y = 1,
    },
  },
}
