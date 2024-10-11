return {
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.concealer"] = {
          config = {
            icon_preset = "varied",
          },
        },
        ["core.text-objects"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              my_workspace = "~/my-workspace/notes",
            },
            index = "index.norg",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "norg", "norg_meta" })
      end
    end,
  },
}
