local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Map leader key to SPC
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Unmap these for my sanity
map("i", "<F1>", "<nop>", opts)
map("n", "<F1>", "<nop>", opts)
map("v", "<F1>", "<nop>", opts)
map("n", "Q", "<nop>", opts)
map("n", "q:", "<nop>", opts)

-- Indent in visual mode and maintain cursor position
map("v", ">", "md>`d:delm d<cr>gv", opts)
map("v", "<", "md<`d:delm d<cr>gv", opts)

-- Remove highlighting
map("n", "\\", ":nohl<cr>", opts)

--Remap for dealing with word wrap
local expr_opts = { noremap = true, expr = true, silent = true }
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

local which_key_ok, wk = pcall(require, "which-key")
if not which_key_ok then
    return
end

for _, mappings in pairs(require("user.keymaps.groups").global) do
    wk.register(mappings)
end
