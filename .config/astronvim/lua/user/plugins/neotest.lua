return {
  {
    "nvim-neotest/neotest",
    ft = { "python" },
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = function()
      return {
        adapters = {
          require "neotest-python",
        },
        quickfix = {
          open = function() vim.cmd "Trouble quickfix" end,
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup(opts)
    end,
  },
}
