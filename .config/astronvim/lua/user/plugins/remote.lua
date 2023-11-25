return {
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      attach_mounts = {
        neovim_config = {
          -- enables mounting local config to /root/.config/nvim in container
          enabled = true,
          -- makes mount readonly in container
          options = { "readonly" },
        },
        neovim_data = {
          -- enables mounting local data to /root/.local/share/nvim in container
          enabled = true,
          -- no options by default
          options = {},
        },
        -- Only useful if using neovim 0.8.0+
        neovim_state = {
          -- enables mounting local state to /root/.local/state/nvim in container
          enabled = true,
          -- no options by default
          options = {},
        },
      },
      -- container_runtime = "devcontainer",
      backup_runtime = "docker",
      -- compose_command = "devcontainer",
      backup_compose_command = "docker compose"
    },
  },
}
