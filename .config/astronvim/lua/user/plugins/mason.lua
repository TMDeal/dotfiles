local utils = require "astronvim.utils"

local mason_lspconfig = {
  "lua_ls",
  "pyright",
  "cssls",
  "html",
  "tsserver",
}

local mason_null_ls = {
  "prettierd",
  "stylua",
  "black",
  "isort",

  "flake8",
  "djlint",
  "eslint",
}

local mason_nvim_dap = {
  "python",
}

return {
  {
    "williamboman/mason.nvim",
    opts = {
      path = "append",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      utils.list_insert_unique(opts.ensure_installed, mason_lspconfig)
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      utils.list_insert_unique(opts.ensure_installed, mason_null_ls)
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    commit = "b874576",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      utils.list_insert_unique(opts.ensure_installed, mason_nvim_dap)
    end,
  },
}
