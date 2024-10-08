return {
  {
    "williamboman/mason.nvim",
    opts = {
      path = "append",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local ok, server_opts = pcall(require, "config.lsp." .. server_name)
          if ok then
            require("lspconfig")[server_name].setup(server_opts)
          end
        end,
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "nvim-dap" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = { handlers = {} },
  },
}
