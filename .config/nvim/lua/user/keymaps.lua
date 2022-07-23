local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Map leader key to SPC
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Unmap these for my sanity
keymap('i', '<F1>', '<nop>', opts)
keymap('n', '<F1>', '<nop>', opts)
keymap('v', '<F1>', '<nop>', opts)
keymap('n', 'Q', '<nop>', opts)
keymap('n', 'q:', '<nop>', opts)

-- Windows splits
keymap('n', '<leader>-', ':<C-u>split<cr>', opts)
keymap('n', '<leader>\\', ':<C-u>vsplit<cr>', opts)

-- Indent in visual mode and maintain cursor position
keymap('v', '>', 'md>`d:delm d<cr>gv', opts)
keymap('v', '<', 'md<`d:delm d<cr>gv', opts)

-- Keep search matches in the middle of the window
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Remove highlighting
keymap('n', '\\', ':nohl<cr>', opts)

--Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Y yank until the end of line
keymap('n', 'Y', 'y$', opts)

-- Remap escape to leave terminal mode
keymap("t", "<ESC>", "<c-\\><c-n>", term_opts)

-- Buffer mappings
keymap("n", "<leader>q", ":Bdelete<CR>", opts)
