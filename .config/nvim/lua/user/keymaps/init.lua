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

keymap({
    key = "S",
    label = "Toggle Spellcheck",
    cmd = "<cmd>setlocal spell!<cr>"
})

keymap({
    key = "q",
    cmd = ":wqa!<CR>",
    label = "Save and Quit (no prompt)"
})

-- Loclist/QuickFix mappings
keymap({
    key = "q",
    cmd = ":cnext<CR>",
    label = "Next Quickfix Item",
    opts = { prefix = "]" }
})
keymap({
    key = "q",
    cmd = ":cprev<CR>",
    label = "Previous Quickfix Item",
    opts = { prefix = "[" }
})
keymap({
    key = "l",
    cmd = ":lnext<CR>",
    label = "Next LocList Item",
    opts = { prefix = "]" }
})
keymap({
    key = "l",
    cmd = ":lprev<CR>",
    label = "Previous LocList Item",
    opts = { prefix = "[" }
})

local project_ok, _ = pcall(require, "project_nvim")
if project_ok then
    keymap({
        key = 'p',
        cmd = [[<cmd>lua require('telescope').extensions.projects.projects()<cr>]],
        label = "Projects"
    })
end

-- Load nvim-notify extension
local notify_ok, _ = pcall(require, "notify")
if notify_ok then
    keymap({
        key = 'N',
        cmd = [[<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({}))<cr>]],
        label = "Notifications"
    })
end

-- load nvim-neoclip extension
local neoclip_ok, _ = pcall(require, "neoclip")
if neoclip_ok then
    keymap({
        key = 'y',
        cmd = [[<cmd>:lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({}))<cr>]],
        label = "Neoclip"
    })
    keymap({
        key = 'm',
        cmd = [[<cmd>:lua require('telescope').extensions.macroscope.default(require('telescope.themes').get_dropdown({}))<cr>]],
        label = "Macros - (q)"
    })
end

require("user.keymaps.files")
require("user.keymaps.buffers")
require("user.keymaps.search")
require("user.keymaps.window")
require("user.keymaps.git")
require("user.keymaps.nvim-tree")
require("user.keymaps.trouble")
require("user.keymaps.pandoc")
