local keymap = require("user.plugins.which-key").register_keymap
local opts = { noremap = true, silent = true }

-- Map leader key to SPC
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Unmap these for my sanity
vim.api.nvim_set_keymap("i", "<F1>", "<nop>", opts)
vim.api.nvim_set_keymap("n", "<F1>", "<nop>", opts)
vim.api.nvim_set_keymap("v", "<F1>", "<nop>", opts)
vim.api.nvim_set_keymap("n", "Q", "<nop>", opts)
vim.api.nvim_set_keymap("n", "q:", "<nop>", opts)

-- Indent in visual mode and maintain cursor position
vim.api.nvim_set_keymap("v", ">", "md>`d:delm d<cr>gv", opts)
vim.api.nvim_set_keymap("v", "<", "md<`d:delm d<cr>gv", opts)

-- Keep search matches in the middle of the window
vim.api.nvim_set_keymap("n", "n", "nzzzv", opts)
vim.api.nvim_set_keymap("n", "N", "Nzzzv", opts)

-- Remove highlighting
vim.api.nvim_set_keymap("n", "\\", ":nohl<cr>", opts)

--Remap for dealing with word wrap
local expr_opts = { noremap = true, expr = true, silent = true }
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Y yank until the end of line
vim.api.nvim_set_keymap("n", "Y", "y$", opts)

-- Remap escape to leave terminal mode
vim.api.nvim_set_keymap("t", "<ESC>", "<c-\\><c-n>", { silent = true })

-- Windows splits
keymap("-", ":<C-u>split<cr>", "Split Window Horizontally")
keymap("\\", ":<C-u>vsplit<cr>", "Split Window Vertically")

-- Buffer mappings
keymap("q", ":Bdelete<CR>", "Close Current Buffer")

-- Loclist/QuickFix mappings
keymap("Q", function()
    local info = vim.fn.getwininfo()

    for _, window in pairs(info) do
        if window.quickfix == 1 then
            vim.cmd [[cclose]]
        else
            vim.cmd [[copen]]
        end
    end
end, "QuickFix")

keymap("q", ":cnext<CR>", "Next Quickfix Item", { prefix = "]" })
keymap("q", ":cprev<CR>", "Previous Quickfix Item", { prefix = "[" })

keymap("L", function()
    local info = vim.fn.getwininfo()

    for _, window in pairs(info) do
        if window.loclist == 1 then
            vim.cmd [[lclose]]
        else
            vim.cmd [[lopen]]
        end
    end
end, "LocList")

keymap("l", ":lnext<CR>", "Next LocList Item", { prefix = "]" })
keymap("l", ":lprev<CR>", "Previous LocList Item", { prefix = "[" })
