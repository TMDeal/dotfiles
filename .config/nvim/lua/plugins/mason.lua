return {
  {
    "mason-org/mason.nvim",
    opts = {
      path = "append",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "nvim-dap" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = { handlers = {} },
  },
}
