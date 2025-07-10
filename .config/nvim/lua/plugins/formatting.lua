return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      maudfmt = {
        command = "maudfmt",
        args = { "-s" },
      },
    },
    formatters_by_ft = {
      ["rust"] = { "rustfmt", "maudfmt" },
    },
  },
}
