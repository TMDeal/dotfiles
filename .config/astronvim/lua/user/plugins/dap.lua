return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    local filters = {}
    dap.defaults.python.exception_breakpoints = filters
  end
}
