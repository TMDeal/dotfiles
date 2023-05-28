return {
  n = {
    -- Unmap these for my sanity
    ["<F1>"] = "<nop>",
    ["Q"] = "<nop>",
    ["q:"] = "<nop>",
    -- Remap for dealing with word wrap
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", noremap = true, expr = true, silent = true },
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", noremap = true, expr = true, silent = true },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>x"] = { name = " Trouble" },
    ["<leader>j"] = { name = " Tasks" },
    ["<leader>jr"] = { "<cmd>OverseerRun<cr>", desc = "Run Task" },
    ["<leader>jc"] = { "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
    ["<leader>jb"] = { "<cmd>OverseerBuild<cr>", desc = "Build Task" },
    ["<leader>jo"] = { "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
    ["<leader>jt"] = { name = "󰙨 Tests" },
    ["<leader>jtt"] = { function() require("neotest").run.run() end, desc = "Run Nearest Test" },
    ["<leader>jtl"] = { function() require("neotest").run.run_last() end, desc = "Run Last Test" },
    ["<leader>jta"] = { function() require("neotest").run.stop() end, desc = "Attach to Nearest Test" },
    ["<leader>jtf"] = { function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run Tests in File" },
    ["<leader>jts"] = { function() require("neotest").run.stop() end, desc = "Stop Test" },
    ["<leader>lV"] = { "<cmd>:VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
  },
  i = {
    ["<F1>"] = "<nop>",
  },
  v = {
    ["<F1>"] = "<nop>",
    [">"] = { "md>`d:delm d<cr>gv", desc = "Indent visual selection to the right" },
    ["<"] = { "md<`d:delm d<cr>gv", desc = "Indent visual selection to the left" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
