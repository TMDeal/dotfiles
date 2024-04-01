local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<leader>|")

map("n", "<leader>\\", "<C-W>v", { desc = "Split window right", remap = true })

-- Clear search with \
map({ "n" }, "\\", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Unmap these for my sanity
map({ "i", "n", "v" }, "<F1>", "<nop>")
map({ "n", "v" }, "Q", "<nop>")
map({ "n", "v" }, "q:", "<nop>")
